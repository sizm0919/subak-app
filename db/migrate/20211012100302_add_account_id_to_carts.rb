class AddAccountIdToCarts < ActiveRecord::Migration[6.1]
  def change
    add_column :carts, :account_id, :integer
  end
end
