# == Schema Information
#
# Table name: ratings
#
#  id         :integer          not null, primary key
#  book_id    :integer          not null
#  user_id    :integer          not null
#  rating     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Rating < ActiveRecord::Base
  attr_accessible :book_id, :rating, :user_id

  validates :book_id, :user_id, :presence => true
  validates :book_id, :uniqueness => {:scope => :user_id,
    :message => "User has already rated this book."}
  validates_inclusion_of :rating, :in => [1,2,3,4,5], :allow_blank => true,
    :message => "Rating can only be in the range of 1 to 5"

  belongs_to :book
  belongs_to :user

  def self.rate(user_id, book_id, user_rating)
    user =  User.find(user_id)
    book = Book.find(book_id)
    rating = Rating.where(user_id: user.id, book_id: book.id).first
    if !rating
      rating = Rating.new(user_id: user.id, book_id: book.id)
    end
    rating.rating = user_rating
    if rating.save!
      true
    else
      false
    end
  end

end
