# == Schema Information
#
# Table name: transactions
#
#  id               :bigint           not null, primary key
#  amount           :float
#  category         :integer
#  description      :string
#  post_date        :date
#  transaction_date :date
#  type             :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  csv_id           :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
