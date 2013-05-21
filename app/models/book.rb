class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :title, :user_id
end
