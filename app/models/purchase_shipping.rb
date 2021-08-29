class PurchaseShipping
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :ship_from_area_id, :municipality, :address, :building_name, :phone_number

  with_options presence: true do
    validates :postal_code, format: {with: /\A\d{3}-\d{4}\z/}
    validates :municipality, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
    validates :address, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/}
    validates :phone_number, format: {with: /\A\d{,11}\z/}
    validates :user_id
    validates :item_id
  end
  validates :ship_from_area_id, numericality: {other_than: 0, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Shipping.create(postal_code: postal_code, municipality: municipality, address: address, phone_number: phone_number, building_name: building_name, ship_from_area_id:ship_from_area_id, purchase_id: purchase.id)
  end

end