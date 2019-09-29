class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.datetime :transaction_date
      t.datetime :post_date
      t.string :description
      t.integer :category
      t.integer :type
      t.float :amount

      t.timestamps
    end
  end
end
