class BuyAddress
  include ActiveModel::Model
  attr_accessor :user_id, :product_id, :postcode, :area_id, :municipality, :address, :building, :phone, :token

  with_options presence: true do
    validates :user_id
    validates :product_id
    validates :postcode, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :area_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality
    validates :address
    validates :phone, format: {with: /\A\d{10,11}\z/, message: "is invalid. Enter a 10 or 11 digit number"}
    validates :token
  end

  def save
    buy = Buy.create(user_id: user_id, product_id: product_id)
    Address.create(postcode: postcode, area_id: area_id, municipality: municipality, address: address, building: building, phone: phone, buy_id: buy.id)
  end
end