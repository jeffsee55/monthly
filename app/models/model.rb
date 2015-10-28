class Model < ActiveRecord::Base
  has_many :units
  belongs_to :channel
end
