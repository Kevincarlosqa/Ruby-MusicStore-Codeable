class AddDefaultToActiveInCustomers < ActiveRecord::Migration[7.0]
  def change
    change_column :customers, :active, :boolean, default:true
  end
end
