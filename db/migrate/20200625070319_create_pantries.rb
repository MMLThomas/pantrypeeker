class CreatePantries < ActiveRecord::Migration
  def change
    create_table :pantries do |t|
      t.string :name
      t.boolean :is_full
      t.integer :user_id
    end
  end
end
