module OrdersHelper
  def translate_status(status)
    case status
    when 'confirmed'
      'Подтвержден'
    when 'pending'
      'В обработке'
    when 'done'
      'Выполнен'
    when 'declined'
      'Откланен'
    end
  end
end
