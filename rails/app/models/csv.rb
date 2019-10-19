# == Schema Information
#
# Table name: csvs
#
#  id          :bigint           not null, primary key
#  account_id  :integer
#  upload_time :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Csv < ApplicationRecord
  belongs_to :account
  has_many :transactions
  has_one_attached :csv_file

  after_create :process_transactions

  def matrix
    return @matrix if @matrix.present?
    @matrix = CSV.parse(csv_file.download)
  end

  def process_transactions
    matrix.shift(account.csv_headers_count) if account.csv_headers_count.present?
    matrix.each do |transaction|
      fields = {
        csv: self,
      }
      transaction.each_with_index do |item, index|
        field_integer = account.fields[index].to_i
        field_symbol = Transaction::FIELDS_LOOKUP[field_integer]
        fields[field_symbol] = item
      end
      puts fields
      Transaction.string_constructor(fields)
    end
    true
  end
end
