# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  amount           :float
#  category         :integer
#  description      :string
#  post_date        :date
#  raw              :string
#  transaction_date :date
#  transaction_type :integer
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
    transaction_type:   6,
  }.freeze
  FIELDS_LOOKUP = FIELDS.invert.freeze

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
    gifts_and_donations:    9,
    entertainment:          10,
    personal:               11, # usually laundry
  }.freeze
  CATEGORIES_LOOKUP = CATEGORIES.invert.freeze

  TRANSACTION_TYPES = {
    sale:     0,
    payment:  1,
    return:   2,
  }.freeze

  class << self
    def string_constructor(hsh)
      fields = {
        csv: hsh[:csv],
        description: hsh[:description],
        raw: hsh.map {|key, value| "#{key}: \"#{value}\""}.join('; '),
      }
      fields[:amount] = hsh[:amount].to_f if hsh[:amount].present?
      if hsh[:transaction_date].present?
        fields[:transaction_date] = Date.strptime(hsh[:transaction_date], '%m/%d/%Y')
      end
      if hsh[:post_date].present?
        fields[:post_date] = Date.strptime(hsh[:post_date], '%m/%d/%Y')
      end
      if hsh[:category].present?
        lookup = {
          'Food & Drink' => :food_and_drink,
          'Groceries' => :groceries,
          'Gifts & Donations' => :gifts_and_donations,
          'Bills & Utilities' => :bills_and_utilities,
          'Shopping' => :shopping,
          'Travel' => :travel,
          'Home' => :home,
          'Professional Services' => :professional_services,
          'Health & Wellness' => :health_and_wellness,
          'Gas' => :travel,
          'Entertainment' => :entertainment,
          'Personal' => :personal,
        }.freeze
        puts "hsh[:category] => \"#{hsh[:category]}\""
        puts "lookup => \"#{lookup[hsh[:category]]}\""
        puts "category => \"#{CATEGORIES[lookup[hsh[:category]]]}\""
        fields[:category] = CATEGORIES[lookup[hsh[:category]]]
        if hsh[:category].present? && CATEGORIES[lookup[hsh[:category]]].nil?
          throw 'uh oh!'
        end
      end
      create(fields)
    end
  end
end
