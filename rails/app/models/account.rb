# == Schema Information
#
# Table name: accounts
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  has_headers :boolean
#

class Account < ApplicationRecord
  has_many :csvs
end
