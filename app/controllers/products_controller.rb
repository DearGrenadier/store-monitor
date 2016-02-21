class ProductsController < ApplicationController
  def index
    @products = Product.all.order(:name)
    @order = Order.new
  end
end
