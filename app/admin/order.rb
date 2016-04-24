ActiveAdmin.register Order do
  menu label: "Заказы"

  config.filters = false
  permit_params :status
  actions :all, except: [:new, :create, :destroy]

  scope -> { 'Все' }, :all
  scope -> { 'Подтвержденные' }, :confirmed, default: true
  scope -> { 'В обработке' }, :pending
  scope -> { 'Выполненные' }, :done
  scope -> { 'Отклоненные' }, :declined

  controller do
    def scoped_collection
      super.includes :user # prevents N+1 queries to your database
    end
  end

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
      row('Статус', &:translate_status)
      row('Общая стоимость', &:total_price)
      row('Дата создания') { |o| o.created_at.strftime('%H:%M  %d-%m-%y') }
      row('Организация') { |o| o.user.organization }
      row('Моб. телефон') { |o| o.user.phone_number }
      table_for order.line_items do
        column('Наименование') { |l_i| l_i.product_attr.product.name }
        column('Размер') { |l_i| l_i.product_attr.size.value }
        column('Количество', &:quantity)
      end
    end
  end

  form do |order_form|
    order_form.inputs 'Заказ' do
      order_form.input :status, as: :select, collection: Order::STATUSES, label: 'Статус'
    end
    actions
  end
end
