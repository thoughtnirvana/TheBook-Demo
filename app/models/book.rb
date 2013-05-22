# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author     :string(255)
#  isbn       :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Book < ActiveRecord::Base
  attr_accessible :author, :isbn, :title

  validates :title, :author, :isbn, :presence => true
  validates_uniqueness_of :isbn

  has_many :ratings
  has_many :users, :through => :ratings, :source => :user

end
