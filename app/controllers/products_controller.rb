class ProductsController < ApplicationController
  def index
    @products = Product.all.select { |p| p.product_attrs.first.size.value != '-' }
      .sort { |a, b| a.product_attrs.min_by(&:price).price <=> b.product_attrs.min_by(&:price).price } +
      Product.all.select { |p| p.product_attrs.first.size.value == '-' }
    @products = ProductDecorator.decorate_collection(@products)
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
