class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:name)
    @order = Order.new
  end

  def create
    @product = Product.create!(product_params)
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, product_attrs_attributes: [:size_id, :price, :amount])
  end
end
