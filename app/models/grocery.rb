class Grocery < ActiveRecord::Base
    belongs_to :pantry
    belongs_to :user


end