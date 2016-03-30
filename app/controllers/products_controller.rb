class ProductsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @products = @products.select { |p| p.product_attrs.first.size.value != '-'.freeze }
                         .sort { |a, b| a.product_attrs.min_by(&:price).price <=> b.product_attrs.min_by(&:price).price } +
                @products.select { |p| p.product_attrs.first.size.value == '-'.freeze }
    @products = ProductDecorator.decorate_collection(@products)
    @order = Order.new
  end
end
