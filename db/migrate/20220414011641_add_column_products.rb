class AddColumnProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :published, :integer, null: false, default: 0
  end
end
