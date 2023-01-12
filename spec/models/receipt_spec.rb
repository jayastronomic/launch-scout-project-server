require 'rails_helper'

RSpec.describe Receipt, type: :model do
  subject { described_class.new(retailer: "Walmart",
                                purchase_date: "2020-01-01",
                                purchase_time: "13:02",
                                total: "4.00",
                                items: [{short_description: "Animal Crackers", price: "4.00"}]
   )} 

  describe "Receipt Model" do 
    it "is valid with valid attributes" do 
      expect(subject).to be_valid
    end

    it "is not valid without a retailer" do
      subject.retailer = ""
      expect(subject).to_not be_valid
    end

    it "is not valid without a purchase date" do
      subject.purchase_date = ""
      expect(subject).to_not be_valid
    end

    it "is not valid without a purchase time" do
      subject.purchase_time = ""
      expect(subject).to_not be_valid
    end

    it "is not valid without a total" do
      subject.total = ""
      expect(subject).to_not be_valid
    end

    it "is not valid without at least one item" do 
      subject.items = ""
      expect(subject).to_not be_valid
    end   
  end
  
  describe "Receipt#points" do
    it "returns the number of points for each receipt based on the rules" do
      expect(subject.points).to be(89) 
    end
  end
end