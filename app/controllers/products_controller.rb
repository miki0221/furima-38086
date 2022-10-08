class ProductsController < ApplicationController

  # 商品一覧機能時に実装するため一時的にコメントアウト
  #def index
  #  @products = Product.order('created_at DESC')
  #end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:image, :title, :content, :category_id, :condition_id, :postage_id, :area_id, :shipping_day_id,
                                    :price).merge(user_id: current_user.id)
  end
end
