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
    matrix.each do |transaction|
      transaction.each do |item|
        #Transaction.create(
        #  csv: self,
        #)
      end
    end
    true
  end
end
