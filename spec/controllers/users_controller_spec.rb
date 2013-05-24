# spec/controllers/users_controller_spec.rb
require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET show" do
    it "assigns the requested user to @user" do
      get :show, id: @user.id
      assigns(:user).should eq(@user)
    end

    it "assigns the user's books to user_books" do
      book = FactoryGirl.create(:book)
      rating = Rating.create!(user_id: @user.id, book_id: book.id, rating: 1)
      get :show, id: @user.id
      assigns(:user_books).should eq([book])
    end
  end

  describe "PUT update" do
    before(:each) do
      @book = FactoryGirl.create(:book)
    end
    it "adds the requested book to user's read list" do
      put :add_book, id: @user.id, book_id: @book.id
      response.body.should == "true"
    end
    it "rates the requested book" do
      put :rate_book, id: @user.id, book_id: @book.id, rating: 1
      response.body.should == "true"
    end
  end

  describe "Admin can change user's rating" do
    before(:each) do
      @admin = FactoryGirl.create(:admin)
      @noadmin = FactoryGirl.create(:user)
      @book = FactoryGirl.create(:book)
      @rating = Rating.create!(user_id: @noadmin.id, book_id: @book.id, rating: 1)
      sign_in @admin
    end

    it "show current rating of user to admin" do
      get :admin_change_user_rating, id: @admin.id, user_id: @noadmin.id,
        book_id: @book.id, rating: @rating.id
      assigns(:user).should eq(@noadmin)
      assigns(:book).should eq(@book)
      assigns(:current_rating).should eq(@rating.rating)
    end

    it "lets admin change user's rating" do
      put :admin_update_user_rating, id: @admin.id, user_id: @noadmin.id,
        book_id: @book.id, rating: 3
      rating = Rating.where(user_id: @noadmin.id, book_id: @book.id).first
      rating.rating.should eq(3)
    end
  end
end
