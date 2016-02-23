ActiveAdmin.register Product do
  permit_params :name
  form partial: 'form'
end
