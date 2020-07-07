class Post < ActiveRecord::Base
belongs_to :user
validates_presence_of :company_name, :position_title
end