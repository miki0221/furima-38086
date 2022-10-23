require 'rails_helper'

RSpec.describe BuyAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    product = FactoryBot.create(:product)
    @buy_address = FactoryBot.build(:buy_address, user_id: user.id, product_id: product.id)
    sleep 0.1
  end

  context '商品購入ができる' do
    it '全ての値が正しく入力できていれば保存ができる' do
      expect(@buy_address).to be_valid
    end
    it 'buildingは空でも保存ができる' do
      @buy_address.building = ''
      expect(@buy_address).to be_valid
    end
  end

  context '商品購入ができない' do
    it 'tokenが空では登録できないこと' do
      @buy_address.token = nil
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Token can't be blank"
    end
    it 'postcodeが空では保存ができない' do
      @buy_address.postcode = ''
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Postcode can't be blank"
    end
    it 'postcodeが半角ハイフンを含む数字3桁+4桁の組み合わせでないと保存ができない' do
      @buy_address.postcode = '1111ー2222'
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include 'Postcode is invalid. Enter it as follows (e.g. 123-4567)'
    end
    it 'area_idが空(未選択)では保存ができない' do
      @buy_address.area_id = 1
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Area can't be blank"
    end
    it 'municipalityが空では保存ができない' do
      @buy_address.municipality = ''
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Municipality can't be blank"
    end
    it 'addressが空では保存ができない' do
      @buy_address.address = ''
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Address can't be blank"
    end
    it 'phoneが空では保存ができない' do
      @buy_address.phone = ''
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Phone can't be blank"
    end
    it 'phoneがハイフンを除いて9桁以下の電話番号は保存ができない' do
      @buy_address.phone = 123_456_78
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include 'Phone is invalid. Enter a 10 or 11 digit number'
    end
    it 'phoneがハイフンを除いて12桁以上の電話番号では保存ができない' do
      @buy_address.phone = 123_456_789_012
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include 'Phone is invalid. Enter a 10 or 11 digit number'
    end
    it 'phoneが英数字混合では保存ができない' do
      @buy_address.phone = '09O-456-890'
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include 'Phone is invalid. Enter a 10 or 11 digit number'
    end
    it 'userが紐づいていないと保存できない' do
      @buy_address.user_id = nil
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "User can't be blank"
    end
    it 'productが紐づいていないと保存できない' do
      @buy_address.product_id = nil
      @buy_address.valid?
      expect(@buy_address.errors.full_messages).to include "Product can't be blank"
    end
  end
end
