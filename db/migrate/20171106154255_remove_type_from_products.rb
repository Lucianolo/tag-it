class RemoveTypeFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :type
    add_column :products, :category, :string
  end
end
