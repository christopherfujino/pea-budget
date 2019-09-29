class AddCsvHeadersToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :csv_headers_count, :integer
  end
end
