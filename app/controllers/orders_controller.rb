class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @order = Order.new(order_params)
    @order.calculate_total_price
    @order.user_id = current_user.id
    @order.save!
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:order][:id])
    @order.line_items.each do |line_item|
      new_quantity = line_item.product.quantity - line_item.quantity
      line_item.product.update(quantity: new_quantity)
    end
    @order.confirmed!
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(line_items_attributes: [:product_attr_id, :quantity])
  end
end
