class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items

  with_options presence: true do
    validates :nickname

    with_options format: { with: /\A[ぁ-んァ-ン一-龥々ー]/, allow_blank: true} do
      validates :family_name
      validates :first_name
    end

    with_options format: {with: /\A[ァ-ヶー－]+\z/, allow_blank: true} do
     validates :family_name_kana
     validates :first_name_kana
    end

    validates :birth
  end

  validates :password, format:{with:/\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, allow_blank: true}
end