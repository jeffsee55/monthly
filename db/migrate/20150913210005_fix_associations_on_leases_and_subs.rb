class FixAssociationsOnLeasesAndSubs < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :plan_id
    add_column :subscriptions, :lease_id, :integer
  end
end
