class Product < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :shipping_day
  # 購入機能時に実装するため一時的にコメントアウト
  # has_one :buy
  has_one_attached :image

  validates :image, presence: true, blob: { content_type: :image }
  validates :title, :content, presence: true
  validates :category_id, :condition_id, :postage_id, :area_id, :shipping_day_id, presence: true,
                                                                                  numericality: { other_than: 1, message: "can't be blank" }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
