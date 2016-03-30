class OrdersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @orders = current_user.orders.where.not(status: 0).order(created_at: :desc)
  end

  def create
    if @order.line_items.empty?
      flash[:alert] = "Не выбрана ни одна из позиций"
      redirect_to :back
    else
      if @order.check_amounts
        @order.calculate_total_price
        @order.user_id = current_user.id
        if @order.save
        else
          flash[:error] = @order.errors.full_messages.join('. ')
          redirect_to :back
        end
      else
        flash[:alert] = "Превышено количество одной из позиций"
        redirect_to :back
      end
    end
  end

  def show; end

  def update
    @order.lock_products
    @order.confirmed!
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