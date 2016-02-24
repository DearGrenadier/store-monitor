class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).where.not(status: :not_confirmed).order(created_at: :desc)
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
      new_amount = line_item.product_attr.amount - line_item.quantity
      line_item.product_attr.update(amount: new_amount)
    end
    @order.confirmed!
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(line_items_attributes: [:product_attr_id, :quantity])
  end
end
