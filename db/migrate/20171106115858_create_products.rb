class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :image
      t.string :type
      t.float :rating_val
      t.integer :rating_count
      t.string :regione
      t.references :company
      t.timestamps
    end
  end
end
