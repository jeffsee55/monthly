class AddLeaseIdToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :lease_id, :integer
  end
end
