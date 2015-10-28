class AddNamesToModels < ActiveRecord::Migration
  def change
    add_column :models, :name, :string
    add_column :users, :name, :string
    add_column :channels, :name, :string
  end
end
