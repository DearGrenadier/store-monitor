class OrderNotifierMailer < ApplicationMailer
  default from: 'example@example.com'

  DEFAULT_RECIEVER = 'gitnazarchuk@gmail.com'

  def new_order_notify(order)
    @order = order
    mail(to: DEFAULT_RECIEVER, subject: 'Новый заказ от #{@order.user.organization}')
  end
end
