class UsersController < ApplicationController

  before_filter :authenticate_user!
  before_filter :validate_self, :only => [:show, :edit, :update]
  before_filter :authenticate_admin, :only => [:admin_change_user_rating,
                                               :admin_change_user_rating]

  def validate_self
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @can_edit = true
    end
  end

  def authenticate_admin
    if !current_user.admin?
      redirect_to root_url, :notice => "You are not authorized to access this page."
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
    rated = Rating.rate(params[:id], params[:book_id], params[:rating])
    if rated
      render :json => true
    else
      render :json => false
    end
  end

  def admin_change_user_rating
    @user = User.find(params[:user_id])
    @book = Book.find(params[:book_id])
    @current_rating = @book.get_rating @user.id
  end

  def admin_update_user_rating
    rated = Rating.rate(params[:user_id], params[:book_id], params[:rating])
    @user = User.find(params[:user_id])
    respond_to do |format|
      if rated
        format.html { redirect_to @user, notice: 'Rating was successfully updated.' }
        format.json { render json: true }
      else
        format.html { redirect_to @user, error: 'Could not update the Rating.' }
        format.json { render json: false }
      end
    end
  end
end
