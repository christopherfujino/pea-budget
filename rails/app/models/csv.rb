class Csv < ApplicationRecord
  belongs_to :account
  has_one_attached :csv_file
end
