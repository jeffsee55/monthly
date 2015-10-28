class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|

      t.timestamps null: false
    end
  end
end
