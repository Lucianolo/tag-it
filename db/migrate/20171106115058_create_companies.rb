class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :description
      t.string :logo
      t.string :website
      t.string :email
      t.string :social
      t.string :phone
      t.string :address
      t.references :user
      t.timestamps
    end
  end
end
