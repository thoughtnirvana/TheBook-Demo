# spec/controllers/ratings_controller_spec.rb
require 'spec_helper'

describe RatingsController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @book = FactoryGirl.create(:book)
    @rating_attributes = { user_id: @user.id, book_id: @book.id, rating: 1 }
  end

  describe "GET index" do
    it "populates an array of ratings" do
      rating = Rating.create! @rating_attributes
      get :index
      assigns(:ratings).should eq([rating])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do
    it "assigns the requested rating to @rating" do
      rating = Rating.create! @rating_attributes
      get :show, id: rating
      assigns(:rating).should eq(rating)
    end
  end

  describe "GET new" do
    it "assigns a new rating as @rating" do
      get :new
      assigns(:rating).should be_a_new(Rating)
    end
  end

  describe "GET edit" do
    it "assigns the requested rating as @rating" do
      rating = Rating.create! @rating_attributes
      get :edit, id: rating.id.to_s
      assigns(:rating).should eq(rating)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Rating" do
        expect {
          post :create, rating: @rating_attributes
        }.to change(Rating, :count).by(1)
      end

      it "assigns a newly created rating as @rating" do
        post :create, rating: @rating_attributes
        assigns(:rating).should be_a(Rating)
        assigns(:rating).should be_persisted
      end

      it "redirects to the created rating" do
        post :create, rating: @rating_attributes
        response.should redirect_to(Rating.last)
      end
    end

    describe "with invalid params" do
      it "doesn't create a new Rating" do
        expect {
          post :create, rating: @rating_attributes.merge(user_id: nil)
        }.to_not change(Rating, :count).by(1)
      end

      it "assigns a newly created but unsaved rating as @rating" do
        post :create,
          rating: @rating_attributes.merge(user_id: nil)
        assigns(:rating).should be_a_new(Rating)
      end

      it "re-renders the 'new' template" do
        post :create,
          rating: @rating_attributes.merge(user_id: nil)
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      @rating = Rating.create @rating_attributes
    end
    describe "with valid params" do
      it "assigns the requested rating as @rating" do
        put :update, id: @rating.id,
          rating: @rating_attributes.merge(rating: 2)
        assigns(:rating).should eq(@rating)
      end

      it "updates attribute of the rating" do
        put :update, id: @rating.id,
          rating: @rating_attributes.merge(rating: 2)
        rating = Rating.find(@rating.id)
        rating.rating.should eq(2)
      end

      it "redirects to the updated rating" do
        put :update, id: @rating.id,
          rating: @rating_attributes.merge(rating: 2)
        response.should redirect_to(@rating)
      end
    end

    describe "with invalid params" do
      it "assigns the rating as @rating" do
        put :update, id: @rating.id.to_s, rating: @rating_attributes.merge(user_id: nil)
        assigns(:rating).should eq(@rating)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @rating.id.to_s, rating: @rating_attributes.merge(user_id: nil)
        response.should render_template("edit")
      end
    end
  end
end
