class Lease < ActiveRecord::Base
  has_many :subscriptions
  belongs_to :unit

  # the lease is a one-to-one relationship with the unit
  # there can only be one lease at a time per unit
  # plans/subscriptions are based on the terms specified in the lease
  # if the terms of a unit change(ie. raised rent), the unit's current lease does not change
  #
  #
  #
  # rate - base rate if not otherwise specified
  # term - specify when the rental should end
  # interval
  # interval count

  state_machine :state, initial: :pending do
    event :start do
      # lease has been created, no signatures yet
      transition pending: :idle
    end

    event :prepare do
      # self.sign
      # lease has been set up with a plan and rate is fulfilled
      transition [:pending, :idle] => :ready
    end

    event :activate do
      # lease start date has begun
      # unit.start_lease
      transition ready: :active
    end

    event :deactivate do
      # unit.stop_lease
      transition active: :idle
    end

    event :unfulfilled do
      # the lease is active but the subscriptions don't add up to the rate
    end

    event :terminate do
      transition idle: :ended
    end
  end
end
