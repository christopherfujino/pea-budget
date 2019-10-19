class AddFieldsToAccounts < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :fields, :string, array: true, default: []
  end
end
