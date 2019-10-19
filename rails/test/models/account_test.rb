# == Schema Information
#
# Table name: accounts
#
#  id                :bigint           not null, primary key
#  csv_headers_count :integer
#  fields            :string           default([]), is an Array
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
