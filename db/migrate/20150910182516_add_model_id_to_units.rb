class AddModelIdToUnits < ActiveRecord::Migration
  def change
    add_column :units, :model_id, :integer
  end
end
