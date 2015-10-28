class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :lease

  # take state from stripe object
  state_machine :state, initial: :pending do

    event :setup do
      # set plan
      transition pending: :ready
    end

    event :activate do
      transition altered: :trialing, unless: :already_started?
      transition altered: :active
    end

    event :alter do
      # the plan has been altered and the leases do not currently meet the
      # lease's terms. The current plan is still active, but will automatically
      # update to the new plan when the lease's terms are met.
      transition [:trialing, :active] => :altered
    end

    event :put_on_probation do
      transition active: :past_due
    end

    event :deactivate do
      transition past_due: :unpaid
    end

    event :reinstate do
      transition unpaid: :active
    end

    event :end do
      transition active: :canceled
    end

    before_transition on: :setup, do: :set_pending_plan # pending -> ready
    before_transition on: :activate, do: :set_plan # ready / altered -> active
    before_transition on: :alter, do: :set_plan # active / active -> altered
    before_transition on: :deactivate, do: :pause # past_due -> unpaid
    before_transition on: :reinstate, do: :activate # unpaid -> active
    before_transition on: :end , do: :cancel # active -> canceled
  end

  private

  def set_pending_plan(options={})
    # Before this plan can be activate, the lease total needs to be met by other
    # subscriptions

    options = {
      interval: "month",
      name: "#{user.name} - #{lease.unit.name}",
      amount: amount,
      currency: "usd",
      id: "#{Time.now.to_i}_#{lease.unit.name}",
      interval_count: 1,
      trial_period_days: null,
      metadata: terms,
      statement_descriptor: "Monthlee Subscription Services"
    }
    self.pending_plan_id = Stripe::Plan.create(
      options
    )
  end

  def set_plan
    if stripe_subscription.plan = plan_id
      self.plan_id = pending_plan_id
    end
  end

  def stripe_subscription
    customer = Stripe::Customer.retrieve(user.stripe_customer_id)
    customer.subscriptions.retrieve(stripe_subscription_id)
  end

  def cancel
    stripe_subscription.delete
  end

  def already_started?
  end
end
