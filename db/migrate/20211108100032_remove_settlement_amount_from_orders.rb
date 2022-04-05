class RemoveSettlementAmountFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :settlement_amount, :integer
  end
end
