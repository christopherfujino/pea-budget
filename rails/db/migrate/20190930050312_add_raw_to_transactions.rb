class AddRawToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :raw, :string
  end
end
