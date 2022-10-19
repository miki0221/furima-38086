class BuysController < ApplicationController
  before_action :set_product, only:[:index, :create]
  before_action :check_product_user, only:[:index, :create]
  

  def index
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      @buy_address.save
      redirect_to root_path
    else
      render :index
    end
  end

    private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def buy_params
      params.require(:buy_address).permit(:postcode, :area_id, :municipality, :address, :building, :phone).merge(user_id: current_user.id, product_id: @product.id)
    end

    def check_product_user
      if current_user.id == @product.user_id || @product.buy.present?
        redirect_to root_path
      end
    end
end
