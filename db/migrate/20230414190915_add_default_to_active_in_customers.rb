class AddDefaultToActiveInCustomers < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up {change_column :customers, :active, :boolean, default:true}
      direction.down {change_column :customers, :active, :boolean}
    end
  end
end
