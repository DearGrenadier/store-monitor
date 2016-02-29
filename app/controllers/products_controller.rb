class ProductsController < ApplicationController
  def index
    @products = Product.all.sort { |a, b| a.product_attrs.min_by { |p_a| p_a.price }.price <=> b.product_attrs.min_by { |p_a| p_a.price }.price }
    @order = Order.new
  end

  def create
    @product = Product.create!(product_params)
    redirect_to :back
  end

  def update
    @product = Product.find(params[:id])
    @product.update!(product_params)
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, product_attrs_attributes: [:id, :size_id, :price, :amount])
  end
end
