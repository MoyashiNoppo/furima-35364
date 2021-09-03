require 'rails_helper'

RSpec.describe PurchaseShipping, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_shipping = FactoryBot.build(:purchase_shipping, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題がない場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping).to be_valid
      end

      it 'building_nameが空白でも保存できること' do
        @purchase_shipping.building_name = ''
        expect(@purchase_shipping).to be_valid
      end
      
    end

    context '内容に問題がある場合' do

      it 'ユーザー情報がなければ登録できない' do
        @purchase_shipping.user_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("User can't be blank")
      end

      it '商品情報がなければ登録できない' do
        @purchase_shipping.item_id = nil
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_codeが空だと保存できない' do
        @purchase_shipping.postal_code = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeの’-’より前が4桁以上あると保存できない' do
        @purchase_shipping.postal_code = '1234-1234'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'postal_codeの’-’より前が2桁以下では保存できない' do
        @purchase_shipping.postal_code = '12-1234'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'postal_codeの’-’より後が5桁以上あると保存できない' do
        @purchase_shipping.postal_code = '123-12345'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'postal_codeの’-’より後が3桁以下では保存できない' do
        @purchase_shipping.postal_code = '123-123'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'postal_codeに’-’が含まれていないと保存できない' do
        @purchase_shipping.postal_code = '1231234'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'postal_codeが数字以外だと保存できない' do
        @purchase_shipping.postal_code = '一二三-いち二三四'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Postal code is invalid")
      end

      it 'municipalityが空だと保存できない' do
        @purchase_shipping.municipality = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'municipalityが半角英数だと保存できない' do
        @purchase_shipping.municipality = 'test'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Municipality is invalid")
      end

      it 'addressが空だと保存できない' do
        @purchase_shipping.address = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address can't be blank")
      end

      it 'addressが半角英数だと保存できない' do
        @purchase_shipping.address = 'test'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Address is invalid")
      end

      it 'phone_numberが空だと保存できない' do
        @purchase_shipping.phone_number = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberは漢字、仮名、カナでは保存できない' do
        @purchase_shipping.phone_number = '一二三四五六七八九じゅう'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberの数字が12桁以上では保存できない' do
        @purchase_shipping.phone_number = '123456789012'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberの数字が9桁以下では保存できない' do
        @purchase_shipping.phone_number = '123456789'
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Phone number is invalid")
      end

      it '配送先の都道府県が未選択では保存できない' do
        @purchase_shipping.ship_from_area_id = 1
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Ship from area can't be blank")        
      end

      it 'tokenが空では保存できない' do
        @purchase_shipping.token = ''
        @purchase_shipping.valid?
        expect(@purchase_shipping.errors.full_messages).to include("Token can't be blank")        
      end
    end
  end
end
