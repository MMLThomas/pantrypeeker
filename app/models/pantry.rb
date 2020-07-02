class Pantry < ActiveRecord::Base
    belongs_to :user
    has_many :groceries

    def self.expired_items(pantry_id)
        @pantry = Pantry.find_by_id(pantry_id)
        @expired = []
        @pantry.groceries.each do |grocery|
           if grocery.expiration_date < Time.new
                @expired << grocery
            end
        end
        @expired
    end

    def self.number_of_expired_items(pantry_id)
        Pantry.expired_items(pantry_id).count
    end
end