class Grocery < ActiveRecord::Base
    belongs_to :pantry
    
    def expired?
        self.expiration_date < Time.new
    end


end