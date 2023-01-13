class Item
  include ActiveModel::API
  attr_accessor :short_description, :price

  validates :short_description, :price, presence: true
  validates :price, format: { with: /\A[0-9]*(\.[0-9]{0,2})?\z/, message: "must be in format: 0.00"}
end