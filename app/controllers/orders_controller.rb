class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = Order.where(user_id: current_user.id).where.not(status: :not_confirmed).order(created_at: :desc)
  end

  def create
    @order = Order.new(order_params)
    if @order.line_items.empty?
      flash[:alert] = "Не выбрана ни одна из позиций"
      redirect_to :back
    else
      if @order.check_amounts
        @order.calculate_total_price
        @order.user_id = current_user.id
        unless @order.save
          flash[:error] = @order.errors.full_messages.join('. ')
          redirect_to :back
        end
      else
        flash[:alert] = "Превышено количество одной из позиций"
        redirect_to :back
      end
    end
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
    OrderNotifierMailer.new_order_notify(@order).deliver
    flash[:notice] = 'Заказ успешно создан и принят на обработку'
    redirect_to root_path
  end

  def accept
    @order = Order.find(params[:order_id])
    @order.pending!
  end

  private

  def order_params
    params.require(:order).permit(line_items_attributes: [:product_attr_id, :quantity])
  end
end
