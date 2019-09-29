class CreateCsvs < ActiveRecord::Migration[6.0]
  def change
    create_table :csvs do |t|
      t.integer :account_id
      t.datetime :upload_time

      t.timestamps
    end
  end
end
