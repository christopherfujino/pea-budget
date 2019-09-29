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

require 'test_helper'

class CsvTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
