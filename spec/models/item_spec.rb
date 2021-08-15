require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do

    context '商品登録できる時' do

      it '商品情報が登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品登録できない時' do
      it '商品名が空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it '商品詳細:カテゴリーが未選択では登録できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品詳細:商品の状態が未選択では登録できない' do
        @item.condition_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '商品詳細:配送料の負担が未選択では登録できない' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
      end
      it '商品詳細:配送元の地域が未選択では登録できない' do
        @item.ship_from_area_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Ship from area can't be blank")        
      end
      it '商品詳細:配送までの日数が未選択では登録できない' do
        @item.days_to_ship_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship can't be blank")
      end
      it '商品詳細:価格が未選択では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '商品詳細:価格が全角では登録できない' do
        @item.price = '８８８'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
    end

  end



end
