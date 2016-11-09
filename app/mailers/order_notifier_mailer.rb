class OrderNotifierMailer < ApplicationMailer
  default from: 'orders@bb-region.gq'

  DEFAULT_RECIEVER = 'opt@goodnight.by'.freeze

  def new_order_notify(order)
    @order = order
    mail(to: DEFAULT_RECIEVER, subject: "Новый заказ от #{@order.user.organization}")
  end
end
