class Receipt
  include ActiveModel::API
  attr_accessor :id, :retailer, :purchase_date, :purchase_time, :total, :items
  attr_reader :points

  validates :retailer, :purchase_date, :purchase_time, :total, :items, presence: true
  validates :purchase_date, format: { with: /\A([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))\z/, message: "date must be in format: YYYY-MM-DD" }
  validates :purchase_time, format: { with: /\A(2[0-3]|[01][0-9]):[0-5][0-9]\z/, message: "only allows military time in format: 00:00"}
  validates :total, format: { with: /\A[0-9]*(\.[0-9]{0,2})?\z/, message: "total must be in format: 0.00"}
  validates :items, length: { minimum: 1, message: "must have at least 1"}

  @@all = []

  def initialize(attributes={})
    super
    @items = attributes[:items].map { |item| Item.new(item)}
  end

  def self.all
    @@all
  end 

  def save!
    if Receipt.all.include?(self)
      p "Receipt already saved!"
      return self
    end
    self.id = SecureRandom.uuid
    Receipt.all.push(self)
    self
  end

  def self.find(recipe_id)
    Receipt.all.find { |recipe| recipe.id == recipe_id }
  end

  

  def points
    points = 0
    points += self.retailer.gsub(/[^a-zA-Z0-9]/, '').length
    points += 50 if self.total.to_f.round == self.total.to_f
    points += 25 if self.total.to_f % 0.25 == 0
    points += (5 * (self.items.length / 2))
    self.items.each do |item|
      if item.short_description.strip.length % 3 == 0
        points += (item.price.to_f * 0.2).ceil
      end
    end
    points += 6 if self.purchase_date[8..10].to_i % 2 == 1
    points += 10 if self.purchase_time.delete(":").to_i.between?(1400, 1600)
    points
  end

  #BONUS METHOD

  def breakdown
    break_down = []

     break_down << ["#{self.retailer.gsub(/[^a-zA-Z0-9]/, '').length.to_s} points", "Retailer name has #{self.retailer.gsub(/[^a-zA-Z0-9]/, '').length.to_s} alphanumeric characters"]

     if self.total.to_f.round == self.total.to_f
      break_down << ["50 points", "Total is a round dollar amount"]
     end

     if self.total.to_f % 0.25 == 0
      break_down << ["25 points", "Total is a multipe of 0.25"]
     end

    
     if self.items.length / 2 >= 1
      break_down << ["#{(5 * (self.items.length / 2))} points", "#{self.items.length} items (2 pairs @ 5 points each)"]
     end

    self.items.each do |item|
      if item.short_description.strip.length % 3 == 0  
        price = format("%.2f", item.price.to_f.round(2)).to_f
        points = format("%.2f", price * 0.2).to_f
        rounded_points = points.ceil      
        description = item.short_description.strip
        description_length = description.length

        break_down << ["#{rounded_points} #{rounded_points == 1 ? "point" : "points"}", "'#{description}' is #{description_length} characters (a multiple of 3).",
        "Item price of #{price} * 0.2 = #{points}, rounded up is #{rounded_points} #{rounded_points == 1 ? "point" : "points"}"]
      end
    end

    if self.purchase_date[8..10].to_i % 2 == 1
      break_down << ["6 points", "Purchase day is odd"]
    end


    if self.purchase_time.delete(":").to_i.between?(1400, 1600)
      break_down << ["10 points", "#{Time.parse(self.purchase_time).strftime("%l:%M%P")} is between 2:00pm and 4:00pm"]
    end

    break_down
  end
end