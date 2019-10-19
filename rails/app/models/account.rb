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

class Account < ApplicationRecord
  has_many :csvs
end
