class AddExpirationDate < ActiveRecord::Migration
  def change
    add_column :groceries, :expiration_date, :datetime 
  end
end
