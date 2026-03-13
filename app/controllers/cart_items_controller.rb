class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart_item, only: [:update, :destroy]

  def index
    @cart_items = current_user.cart_items.includes(:product)
  end

  def create
    @product = Product.find(params[:product_id])

    cart_item = current_user.cart_items.find_or_initialize_by(product: @product)
    cart_item.quantity ||= 0
    cart_item.quantity += 1
    cart_item.save!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: shop_path }
    end
  end

  def update
    new_quantity = params[:quantity].to_i
    @product = @cart_item.product

    if new_quantity <= 0
      @cart_item.destroy
    else
      @cart_item.update(quantity: new_quantity)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: shop_path }
    end
  end

  def destroy
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private

  def set_cart_item
    @cart_item = current_user.cart_items.find(params[:id])
  end
end