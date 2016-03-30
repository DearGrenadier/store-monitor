ActiveAdmin.register User do
  menu label: "Пользователи"
  config.filters = false

  permit_params :alert
  actions :all, except: [:new, :create, :show]

  index do
    selectable_column
    column 'Email', :email
    column 'Моб. номер', :phone_number
    column 'Организация', :organization
    actions
  end

  show do
    attributes_table do
      row('Email') { |u| u.email }
      row('Моб. номер') { |u| u.phone_number }
      row('Организация') { |u| u.organization }
    end
  end

  form do |f|
   inputs 'Пользователь' do
     input :alert, label: 'Уведомлять о заказах'
   end
   actions
  end
end
