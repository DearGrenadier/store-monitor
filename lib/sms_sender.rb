require "addressable/template"

class SMSSender
  @smsc = YAML.load_file('config/smsc.yml')

  DEFAULT_MESSAGE = 'Поступил новый заказ'.freeze
  URL = "http://smsc.ru/sys/send.php/{?query*}/".freeze
  U = "http://smsc.ru/sys/send.php?login=nazarchuk&psw=real2010&phones=375298980080&charset=utf-8&mes=Поступил+новый+заказ".freeze
  @params = {query: { login: @smsc['credentials']['login'],
             psw: @smsc['credentials']['password'],
             phones: @smsc['recievers'].join(';') },
             charset: 'utf-8'}

  def self.send_message(message = DEFAULT_MESSAGE)
    @params[:query][:mes] = message
    send_request
  end

  private

  def self.send_request
    uri = Addressable::Template.new(URL)
    uri = uri.expand(@params)
    Net::HTTP.get(uri)
  end
end
