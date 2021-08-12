class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :days_to_ship
  belongs_to :ship_from_area
  belongs_to :shipping_charge
  
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :description
    validates :price

    with_options numericality: { other_than: 1 , message: "can't be blank"} do
      validates :category_id
      validates :condition_id
      validates :shipping_charge_id
      validates :ship_from_area_id
      validates :days_to_ship_id
    end
  end
end
