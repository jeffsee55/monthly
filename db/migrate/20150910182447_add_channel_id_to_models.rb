class AddChannelIdToModels < ActiveRecord::Migration
  def change
    add_column :models, :channel_id, :integer
  end
end
