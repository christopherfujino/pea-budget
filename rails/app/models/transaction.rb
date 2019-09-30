# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  transaction_date :datetime
#  post_date        :datetime
#  description      :string
#  category         :integer
#  type             :integer
#  amount           :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  csv_id           :integer
#

class Transaction < ApplicationRecord
  belongs_to :csv

  FIELDS = {
    transaction_date:   0,
    post_date:          1,
    transaction_number: 2,
    description:        3,
    category:           4,
    amount:             5,
  }.freeze

  CATEGORIES = {
    food_and_drink:         0,
    groceries:              1,
    shopping:               2,
    bills_and_utilities:    3,
    travel:                 4,
    personal:               5,
    professional_services:  6,
    health_and_wellness:    7,
    home:                   8,
  }.freeze

  TYPE = {
    sale:     0,
    payment:  1,
    return:   2,
  }.freeze
end
