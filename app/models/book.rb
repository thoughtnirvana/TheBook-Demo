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
  paginates_per 5
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
end
