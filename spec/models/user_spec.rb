require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'name、email、password、password_confirmation、ユーザー名（漢字/カタカナ）、誕生日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      context 'nickname関連' do
        it 'nicknameが空では登録できない' do
          @user.nickname = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Nickname can't be blank"
        end
      end

      context 'email関連' do
        it 'emailは空では登録できない' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Email can't be blank"
        end
        it 'emailに「@」が含まれていないと登録できない' do
          @user.email = 'test.com'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Email is invalid'
        end
        it 'すでに登録されているemailは登録できない' do
          @user.save
          user2 = FactoryBot.build(:user)
          user2.email = @user.email
          user2.valid?
          expect(user2.errors.full_messages).to include 'Email has already been taken'
        end
      end

      context 'password関連' do
        it 'passwordが空では登録できない' do
          @user.password = ''
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Password can't be blank",
                                                        'Password is invalid. Include both letters and numbers'
        end
        it 'passwordが6文字以下では登録できない' do
          @user.password = 'test1'
          @user.password_confirmation = 'test1'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Password is too short (minimum is 6 characters)'
        end
        it 'passwordが129文字以上では登録できない' do
          @user.password = '1a' + Faker::Internet.password(min_length: 129)
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include 'Password is too long (maximum is 128 characters)'
        end
        it 'passwordが英数字混合でないと登録できない(英字のみ)' do
          @user.password = 'testtest'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
        end
        it 'passwordが英数字混合でないと登録できない(数字のみ)' do
          @user.password = '1111111'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
        end
        it 'passwordが英数字混合でないと登録できない(全角)' do
          @user.password = 'ｔｅｓｔ１１１'
          @user.password_confirmation = @user.password
          @user.valid?
          expect(@user.errors.full_messages).to include 'Password is invalid. Include both letters and numbers'
        end
        it 'passwordとpassword_confirmationが不一致では登録できない' do
          @user.password = 'test111'
          @user.password_confirmation = 'test222'
          @user.valid?
          expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
        end
      end

      context 'ユーザー名（漢字）関連' do
        it 'last_name_kanjiが空では登録できない' do
          @user.last_name_kanji = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Last name kanji can't be blank",
                                                        'Last name kanji is invalid. Input full-width characters'
        end
        it 'first_name_kanjiが空では登録できない' do
          @user.first_name_kanji = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "First name kanji can't be blank",
                                                        'First name kanji is invalid. Input full-width characters'
        end
        it 'last_name_kanjiが漢字・ひらがな・カタカナ以外では登録できない' do
          @user.last_name_kanji = 'test000'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Last name kanji is invalid. Input full-width characters'
        end
        it 'first_name_kanjiが漢字・ひらがな・カタカナ以外では登録できない' do
          @user.first_name_kanji = 'test000'
          @user.valid?
          expect(@user.errors.full_messages).to include 'First name kanji is invalid. Input full-width characters'
        end
      end

      context 'ユーザー名（カタカナ）関連' do
        it 'last_name_kanaが空では登録できない' do
          @user.last_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Last name kana can't be blank",
                                                        'Last name kana is invalid. Input full-width katakana characters'
        end
        it 'first_name_kanaが空では登録できない' do
          @user.first_name_kana = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "First name kana can't be blank",
                                                        'First name kana is invalid. Input full-width katakana characters'
        end
        it 'last_name_kanaがカタカナ以外では登録できない' do
          @user.last_name_kana = 'testてすと漢字'
          @user.valid?
          expect(@user.errors.full_messages).to include 'Last name kana is invalid. Input full-width katakana characters'
        end
        it 'first_name_kanaがカタカナ以外では登録できない' do
          @user.first_name_kana = 'testてすと漢字'
          @user.valid?
          expect(@user.errors.full_messages).to include 'First name kana is invalid. Input full-width katakana characters'
        end
      end

      context '誕生日関連' do
        it '誕生日が空では登録できない' do
          @user.birth_id = ''
          @user.valid?
          expect(@user.errors.full_messages).to include "Birth can't be blank"
        end
      end
    end
  end
end
