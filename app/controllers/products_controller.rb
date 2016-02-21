class ProductsController < ApplicationController
  def index
    @products = Product.all
    @order = Order.new
  end
end
