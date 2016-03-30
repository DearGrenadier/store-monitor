ActiveAdmin.register Product do
  config.filters = false

  menu label: 'Товары'

  permit_params :name, product_attrs_attributes: [:id, :size_id, :price, :amount]

  actions :all

  index do
    selectable_column
    column 'Наименование', :name
    actions
  end

  show do
    attributes_table do
      row('Наименование') { |p| p.name }
      table_for product.product_attrs do
        column('Размер') { |p_a| p_a.size.value }
        column('Цена за ед.') { |p_a| p_a.price }
        column('Наличие') { |p_a| p_a.amount }
      end
    end
  end

  form do |product_form|
    product_form.inputs do
      product_form.input :name, label: 'Наименование'
      product_form.has_many :product_attrs, allow_destroy: true do |product_attr_form|
        product_attr_form.input :size_id, as: :select, collection: Size.pluck(:value, :id), label: 'Размер'
        product_attr_form.input :price, label: 'Цена'
        product_attr_form.input :amount, label: 'Количество'
      end
    end
    actions
  end
end
