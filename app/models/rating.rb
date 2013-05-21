class Rating < ActiveRecord::Base
  attr_accessible :book_id, :rating, :user_id
end
