class OrderNotifierMailer < ApplicationMailer
  default from: 'example@example.com'

  DEFAULT_RECIEVER = 'info@matrason.by'

  def new_order_notify(order)
    @order = order
    mail(to: DEFAULT_RECIEVER, subject: "Новый заказ от #{@order.user.organization}")
  end
end
