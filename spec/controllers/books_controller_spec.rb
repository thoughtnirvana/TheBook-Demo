# spec/controllers/books_controller_spec.rb
require 'spec_helper'

describe BooksController do
  include Devise::TestHelpers

  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET index" do
    it "populates an array of books" do
      book = FactoryGirl.create(:book)
      get :index
      assigns(:books).should eq([book])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do
    it "assigns the requested book to @book" do
      book = FactoryGirl.create(:book)
      get :show, id: book
      assigns(:book).should eq(book)
    end

    it "renders the show view" do
      get :show, id: FactoryGirl.create(:book)
      response.should render_template :show
    end
  end

  describe "GET new" do
    it "assigns a new book as @book" do
      get :new
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    it "assigns the requested book as @book" do
      book = FactoryGirl.create(:book)
      get :edit, id: book.id.to_s
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, book: FactoryGirl.attributes_for(:book)
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, book: FactoryGirl.attributes_for(:book)
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, book: FactoryGirl.attributes_for(:book)
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      it "doesn't create a new Book" do
        expect {
          post :create, book: FactoryGirl.attributes_for(:invalid_book)
        }.to_not change(Book, :count).by(1)
      end

      it "assigns a newly created but unsaved book as @book" do
        post :create,
          book: FactoryGirl.attributes_for(:invalid_book)
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        post :create,
          book: FactoryGirl.attributes_for(:invalid_book)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @book = FactoryGirl.create(:book, title: "Title1")
      Rating.create!(book_id: @book.id, user_id: @user.id, rating: 1)
    end
    describe "with valid params" do
      it "assigns the requested book as @book" do
        put :update, id: @book.id,
          book: FactoryGirl.attributes_for(:book)
        assigns(:book).should eq(@book)
      end

      it "updates attribute of the book" do
        put :update, id: @book.id,
          book: FactoryGirl.attributes_for(:book, title: "Title2")
        book = Book.find(@book.id)
        book.title.should eq("Title2")
      end

      it "redirects to the updated book" do
        put :update, id: @book.id,
          book: FactoryGirl.attributes_for(:book, title: "Title3")
        response.should redirect_to(@book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        put :update, id: @book.id.to_s, book: FactoryGirl.attributes_for(:invalid_book)
        assigns(:book).should eq(@book)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @book.id.to_s, book: FactoryGirl.attributes_for(:invalid_book)
        response.should render_template("edit")
      end
    end
  end
end
