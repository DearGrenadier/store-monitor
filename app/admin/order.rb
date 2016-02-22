ActiveAdmin.register Order do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
  ActiveAdmin.register LineItem do
    belongs_to :order
    navigation_menu :order
  end

  menu label: "Заказы"

  actions :all, except: [:new, :create, :destroy]

  scope :all
  scope :confirmed, default: true
  scope "В обработке", :pending
  scope :done
  scope :declined

  index do
    selectable_column
    column "Статус", :status
    column "Дата создания", :created_at
    column "Заказчик", :user, :email
    column "Сумма заказа(руб.)", :total_price
    actions
  end

  show do
    attributes_table do
      render 'show'
    end
  end
end
