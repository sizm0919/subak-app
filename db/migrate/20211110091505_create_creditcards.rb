class CreateCreditcards < ActiveRecord::Migration[6.1]
  def change
    create_table :creditcards do |t|
      t.references :account,  foreign_key: true, null: false
      t.string :payjp_id, null: false
      t.timestamps
    end
  end
end
