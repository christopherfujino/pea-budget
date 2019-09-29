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

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
