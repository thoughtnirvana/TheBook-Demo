class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :validate_self, :only => [:show, :edit, :update]

  def validate_self
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @can_edit = true
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user_books = @user.books.page params[:page]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    if !@can_edit
      redirect_to user_path(@user), :notice => "You are not allowed to edit the " +
      "information of other users."
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if !@can_edit
      redirect_to user_path(@user), :notice => "You are not allowed to edit the " +
      "information of other users."
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/add_book
  def add_book
    @user = User.find(params[:id])
    @book = Book.find(params[:book_id])
    rating = Rating.new(user_id: @user.id, book_id: @book.id)
    if rating.save!
      render :json => true
    else
      render :json => false
    end
  end

  # PUT /users/1/rate_book
  def rate_book
    @user = User.find(params[:id])
    @book = Book.find(params[:book_id])
    rating = Rating.where(user_id: @user.id, book_id: @book.id).first
    if !rating
      rating = Rating.new(user_id: @user.id, book_id: @book.id)
    end
    rating.rating = params[:rating]
    if rating.save!
      render :json => true
    else
      render :json => false
    end
  end
end
