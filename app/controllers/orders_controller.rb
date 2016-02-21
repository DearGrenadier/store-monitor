class OrdersController < ApplicationController
  def index
  end

  def confirmation
    @order = Order.new(order_params)
    @order.calculate_total_price
    @order.save!
  end

  def show
  end

  def update
    @order = Order.find(params[:order][:id])
    @order.pending!
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(line_items_attributes: [:product_id, :quantity])
  end
end
