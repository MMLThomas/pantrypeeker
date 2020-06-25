class User < ActiveRecord::Base
    has_secure_password
    belongs_to :friend
    has_many :users, through: :friend

    
end