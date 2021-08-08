require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    
    context '新規登録できるとき' do
      it 'ニックネーム,email,password,password_confimation,familyname,familyname_kana,firstname,firstname_kana,birthが存在すれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordとpassword_confirmationが６文字以上であれば登録できる' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end

      it 'ユーザー本名_苗字（漢字）が、”カタカナ”で登録できる' do
        @user.family_name = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'ユーザー本名_苗字（漢字）が、”ひらがな”で登録できる' do
        @user.family_name = 'やまだ'
        expect(@user).to be_valid
      end

      it 'ユーザー本名_名前（漢字）が、”カタカナ”で登録できる' do
        @user.first_name = 'タロウ'
        expect(@user).to be_valid
      end
      
      it 'ユーザー本名_名前（漢字）が、”ひらがな”で登録できる' do
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end
        end

    context 'ユーザー登録できない時' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = '' 
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したメールアドレスがある時は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスに”@”が含まれない時は登録できない' do
        @user.email = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが５文字以下では登録できない' do
        @user.password = 'aaaaa'
        @user.password_confirmation = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it 'パスワードが記述されていても、確認パスワードが空では保存できない。' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'パスワードと確認パスワードが一致しないと保存できない。' do
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'ユーザー本名_苗字（漢字）が空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it 'ユーザー本名_苗字（漢字）が半角英数では登録できない' do
        @user.family_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end

      it 'ユーザー本名_名前（漢字）が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'ユーザー本名_名前（漢字）が半角英数では登録できない' do
        @user.first_name = 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'ユーザー本名_苗字（カナ）が空では登録できない'do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it 'ユーザー本名_苗字（カナ）が半角英数では登録できない'do
        @user.family_name_kana = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end

      it 'ユーザー本名_苗字（カナ）が漢字では登録できない'do
        @user.family_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end

      it 'ユーザー本名_名前（カナ）が空では登録できない'do
        @user.first_name_kana= ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'ユーザー本名_名前（カナ）が半角英数では登録できない'do
        @user.first_name_kana= 'tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it 'ユーザー本名_名前（カナ）が漢字では登録できない'do
        @user.first_name_kana= '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it '生年月日が空では登録できない'do
        @user.birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth can't be blank")
      end
    end
  end
end
