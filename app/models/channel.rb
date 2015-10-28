# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Channel < ActiveRecord::Base
  has_many :models
end
