class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.string :description
      t.integer :term
      t.string :interval
      t.datetime :start_date
      t.integer :due_day
      t.integer :property_id

      t.timestamps null: false
    end
  end
end
