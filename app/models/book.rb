# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  author     :string(255)      not null
#  isbn       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ActiveRecord::Base
  paginates_per 10
  attr_accessible :author, :isbn, :title

  validates :title, :author, :isbn, :presence => true
  validates_uniqueness_of :isbn

  has_many :ratings
  has_many :users, :through => :ratings, :source => :user

  def self.search(search_term, page)
    if !search_term
      return Book.order(:title).page(page)
    end
    Book.where('(lower(title) like ?) or (lower(author) like ?) or (lower(isbn) like ?)',
      "%#{search_term}%", "%#{search_term}%", "%#{search_term}%").order(:title).page(page)
  end

  def self.create_new(params, current_user=nil)
    book = Book.new(params[:book])
    Book.transaction do
      begin
        book.save!
        if current_user
          rating = Rating.new(user_id: current_user.id, book_id: book.id)
          rating.save!
        end
      rescue ActiveRecord::RecordInvalid
        raise ActiveRecord::Rollback
      end
    end
    book
  end

  def get_rating user_id
    user = User.find(user_id)
    rating = ratings.where(:user_id => user_id).first
    if rating and rating.rating
      rating.rating
    else
      "Not Rated"
    end
  end
end
