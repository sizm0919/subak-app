class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.text :name
      t.integer :account_id
      t.text :postal_code
      t.text :address
      t.text :representative_name
      t.text :co_number
      t.date :co_registration_date
      t.string :farmer
      t.string :wholesale
      t.string :retail
      t.string :restaurant
      t.string :homemeal

      t.timestamps
    end
  end
end
