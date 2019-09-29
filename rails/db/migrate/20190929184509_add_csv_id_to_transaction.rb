class AddCsvIdToTransaction < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :csv_id, :integer
  end
end
