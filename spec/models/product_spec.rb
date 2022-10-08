require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @product = FactoryBot.build(:product)
  end

  describe '商品出品' do
    context '商品出品ができる' do
      it 'image、title、content、category_id、condition_id、postage_id、area_id、shipping_day_id、priceが存在すれば登録できる' do
        expect(@product).to be_valid
      end
    end
    context '商品出品ができない' do
      it 'imageが空では登録できない' do
        @product.image = nil
        @product.valid?
        expect(@product.errors.full_messages).to include "Image can't be blank"
      end
      it 'titleが空では登録できない' do
        @product.title = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Title can't be blank"
      end
      it 'contentが空では登録できない' do
        @product.content = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Content can't be blank"
      end
      it 'category_idが空では登録できない' do
        @product.category_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Category can't be blank"
      end
      it 'condition_idが空では登録できない' do
        @product.condition_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Condition can't be blank"
      end
      it 'postage_idが空では登録できない' do
        @product.postage_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Postage can't be blank"
      end
      it 'area_idが空では登録できない' do
        @product.area_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Area can't be blank"
      end
      it 'shipping_day_idが空では登録できない' do
        @product.shipping_day_id = 1
        @product.valid?
        expect(@product.errors.full_messages).to include "Shipping day can't be blank"
      end
      it 'priceが空では登録できない' do
        @product.price = ''
        @product.valid?
        expect(@product.errors.full_messages).to include "Price can't be blank"
      end
      it 'ユーザーが紐づいていないと登録ができない' do
        @product.user = nil
        @product.valid?
        expect(@product.errors.full_messages).to include 'User must exist'
      end
      it 'priceが半角数字でないと登録できない' do
        @product.price = '１０００'
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price is not a number'
      end
      it 'priceが¥300以下だと登録できない' do
        @product.price = 299
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be greater than or equal to 300'
      end
      it 'priceが¥9,999,999以上だと登録できない' do
        @product.price = 10_000_000
        @product.valid?
        expect(@product.errors.full_messages).to include 'Price must be less than or equal to 9999999'
      end
    end
  end
end
