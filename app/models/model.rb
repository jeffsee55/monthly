# == Schema Information
#
# Table name: models
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  channel_id :integer
#  name       :string
#

class Model < ActiveRecord::Base
  has_many :units
  belongs_to :channel
end
