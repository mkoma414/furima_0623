class OrderAddress
  include ActiveModel::Model
  attr_accessor :postcode, :prefecture_id, :city, :phone_number, :building, :block, :item_id, :user_id, :token

  with_options presence: true do
    validates :token
    validates :city
    validates :block
    validates :user_id
    validates :item_id
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'に(-)を含めてください' }
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: "は使用できません" }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を入力してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, phone_number: phone_number,
                   building: building, order_id: order.id)
  end
end
