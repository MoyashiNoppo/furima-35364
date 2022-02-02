class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :days_to_ship
  belongs_to :ship_from_area
  belongs_to :shipping_charge
  
  belongs_to :user
  has_one :purchase

  has_one_attached :image

  with_options presence: true do
      validates :image
      validates :name, length: {maximum: 50, allow_blank:true}
      validates :description, length: {maximum:1000, allow_blank:true}
      validates :price, numericality: {allow_blank: true, only_integer: true, greater_than_or_equal_to:300, less_than_or_equal_to:9999999}
    with_options numericality: { other_than: 1 , message: "を入力してください"} do
      validates :category_id
      validates :condition_id
      validates :shipping_charge_id
      validates :ship_from_area_id
      validates :days_to_ship_id
    end
  end
end
