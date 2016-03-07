ActiveAdmin.register Order do
  menu label: "Заказы"

  config.filters = false
  permit_params :status
  actions :all, except: [:new, :create, :destroy]

  scope -> { 'Все' }, :all
  scope -> { 'Подтвержденные' }, :confirmed, default: true
  scope -> { 'В обработке' }, :pending
  scope -> { 'Выполненные' }, :done
  scope -> { 'Откланенные' }, :declined

  index do
    selectable_column
    column "Статус", :translate_status
    column "Дата создания", :created_at
    column('Заказчик') { |o| o.user.organization }
    column('Моб. номер') { |o| o.user.phone_number }
    column "Сумма заказа(руб.)", :total_price
    actions
  end

  show do
    attributes_table do
      row('Статус') { |o| o.translate_status }
      row('Общая стоимость') { |o| o.total_price }
      row('Дата создания') { |o| o.created_at }
      row('Организация') { |o| o.user.organization }
      row('Моб. телефон') { |o| o.user.phone_number }
      table_for order.line_items do
        column('Наименование') { |l_i| l_i.product_attr.product.name }
        column('Размер') { |l_i| l_i.product_attr.size.value }
        column('Количество') { |l_i| l_i.quantity }
      end
    end
  end

  form do |f|
   inputs 'Заказ' do
     input :status, as: :select, collection: Order::STATUSES, label: 'Статус'
   end
   actions
  end
end
