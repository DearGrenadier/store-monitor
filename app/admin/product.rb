ActiveAdmin.register Product do
  menu label: "Товары"

  permit_params :name

  form partial: 'form'

  index do
    selectable_column
    column "Наименование", :name
    actions
  end

  show do
    attributes_table do
      row :name
      table_for product.product_attrs do
        column('Размер') { |p_a| p_a.size.value }
        column('Цена за ед.') { |p_a| p_a.price }
        column('Наличие') { |p_a| p_a.amount }
      end
    end
  end
end
