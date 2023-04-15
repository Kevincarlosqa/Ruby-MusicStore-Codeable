class ChangeColumnToArtists < ActiveRecord::Migration[7.0]
  def change
    reversible do |direction|
      direction.up {change_column :artists, :biography, :text}
      direction.down {change_column :artists, :biography, :string}
    end
  end
end
