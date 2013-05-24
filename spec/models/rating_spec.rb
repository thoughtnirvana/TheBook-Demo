# spec/models/rating_spec.rb
require 'spec_helper'

describe Rating do
  before(:each) do
    user = FactoryGirl.create(:user)
    book = FactoryGirl.create(:book)
    rating = 1
    @attr = { book_id: book.id, user_id: user.id, rating: rating }
  end

  it "is a valid instance" do
    Rating.new(@attr).should be_valid
  end

  it "is invalid without a book id" do
    Rating.new(@attr.merge(book_id: nil)).should_not be_valid
  end

  it "is invalid without a user id" do
    Rating.new(@attr.merge(user_id: nil)).should_not be_valid
  end

  it "is valid without a rating" do
    Rating.new(@attr.merge(rating: nil)).should be_valid
  end
end
