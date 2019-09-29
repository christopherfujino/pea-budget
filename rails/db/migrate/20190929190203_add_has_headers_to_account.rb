class AddHasHeadersToAccount < ActiveRecord::Migration[6.0]
  def change
    add_column :accounts, :has_headers, :boolean
  end
end
