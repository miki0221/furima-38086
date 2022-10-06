class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :buy
  has_one_attached :image

  validates :image, presence: true, blob: { content_type: :image }
  validates :title, :content, :price, presence: true
  validates :category_id, :condition_id, :postage_id, :area_id, :shipping_day_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

end
