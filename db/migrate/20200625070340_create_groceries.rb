class CreateGroceries < ActiveRecord::Migration
  def change 
    create_table :groceries do |t|
      t.string :name 
      t.integer :count 
      t.datetime :purchase_date
      t.integer :pantry_id
    end
  end
end
