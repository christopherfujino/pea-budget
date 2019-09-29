class Csv < ApplicationRecord
  belongs_to :account
  has_one_attached :csv_file

  after_create :process_transactions

  def matrix
    return @matrix if @matrix.present?
    @matrix = CSV.parse(csv_file.download)
  end

  def process_transactions
    matrix.each do |transaction|
      transaction.each do |item|
        puts item
      end
    end
    true
  end
end
