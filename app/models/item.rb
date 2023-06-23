class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_day
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :name, :content, :image, presence: true
  validates :category_id, :status_id, :shipping_cost_id, :shipping_day_id,
            :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }
  validates :price, presence: true
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'が入力できる範囲外です' }
  validates :price, numericality: { only_integer: true, message: 'を半角数字で入力してください' }
end
