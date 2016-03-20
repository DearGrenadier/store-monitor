class AddAlertToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :alert, :boolean, default: true
  end
end
