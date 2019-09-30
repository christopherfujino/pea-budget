class ChangeTimeStampsTransactions < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :transaction_date, :date
    change_column :transactions, :post_date, :date
  end
end
