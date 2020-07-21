class User < ActiveRecord::Base
    has_many :posts
    has_secure_password
    validates_presence_of :username, :email, :password
    ##Adds validations for username and email so that only one user can have either
    validates_uniqueness_of :username
end