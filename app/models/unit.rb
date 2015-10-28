# == Schema Information
#
# Table name: units
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  term        :integer
#  interval    :string
#  start_date  :datetime
#  due_day     :integer
#  property_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  model_id    :integer
#

class Unit < ActiveRecord::Base
  has_many :leases
  belongs_to :model

  def active_lease
    if leases.last.state == "active"
      leases.last
    else
      "None"
    end
  end

  state_machine :state, initial: :pending do
    event :start do
      transition pending: :idle
    end

    event :start_lease do
      transition idle: :leased
    end

    event :stop_lease do
      transition leased: :idle
    end

    event :adjusted do
      # unit's model's properties have been changed but the current leases are
      # under older property terms
      # eg. rent raised from $100 to $110 will not initiate until next lease
    end
  end
end
