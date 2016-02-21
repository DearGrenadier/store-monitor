class ProductsController < ApplicationController
  def index
    @products = Product.all
    @oreder = Order.new
  end
end
