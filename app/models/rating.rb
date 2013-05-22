# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  book_id    :integer
#  user_id    :integer
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :book_id, :rating, :user_id

  validates :book_id, :user_id, :presence => true

  belongs_to :book
  belongs_to :user
end
