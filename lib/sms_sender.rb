require 'addressable/template'
require 'action_view'

class SMSSender
  extend ActionView::Helpers::NumberHelper

  URL = 'http://smsc.ru/sys/send.php{?query*}'

  @smsc = YAML.load_file('config/smsc.yml')
  @params = {query: { login: @smsc['credentials']['login'],
             psw: @smsc['credentials']['password'],
             phones: @smsc['recievers'].join(';') } }

  def self.send_message(user, order)
    @params[:query][:mes] = compasite_message(user, order)
    @params[:query][:charset] = 'utf-8'
    send_request
  end

  def self.send_request
    uri = Addressable::Template.new(URL)
    uri = uri.expand(@params)
    Net::HTTP.get(uri)
  end

  def self.compasite_message(user, order)
    res = "Поступил новый заказ от #{user.organization}(#{user.phone_number}).\n"
    order.line_items.each do |line_item|
      res.concat "#{line_item.quantity} x #{line_item.product_attr.product.name}\
                  (#{line_item.product_attr.size.value})\n"
    end
    res.concat "Общая стоимость заказа - #{number_to_currency(order.total_price, delimiter: ' ',
                                                              precision: 0, format: '%n руб.')}"
  end
end
