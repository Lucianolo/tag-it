class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :text
      t.integer :rating
      t.references :user
      t.references :product
      t.timestamps
    end
  end
end
