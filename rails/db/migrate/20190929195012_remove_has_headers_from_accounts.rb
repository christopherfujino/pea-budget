class RemoveHasHeadersFromAccounts < ActiveRecord::Migration[6.0]
  def change
    remove_column :accounts, :has_headers, :boolean
  end
end
