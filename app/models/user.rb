class User < ActiveRecord::Base
  has_many :subscriptions

  state_machine :state, initial: :pending do

    event :activate do
      #has a valid source of payment
      transition pending: :active
    end

    event :pause do
      # there is not a valid source, but no payments missed
      transition active: :paused
    end

    event :probate do
      # if a user is delinquent
      transition [:active, :paused] => :delinquent
    end

    event :deactivate do
      transition all => :inactive
    end
  end
end
