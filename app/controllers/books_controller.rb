class BooksController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:index]
  before_filter :validate_owner, :only => [:show, :edit, :update, :destroy]

  def validate_owner
    @book = Book.find(params[:id])
    if @book.users.include? current_user
      @can_edit = true
      @current_user_rating = @book.ratings.where(:user_id => current_user.id).first
    end
  end

  # GET /books
  # GET /books.json
  def index
    @books = Book.search params[:search], params[:page]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    if !@can_edit
      redirect_to books_path, :notice => "You are not allowed to edit the " +
      "books that have been added by others."
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    if !@can_edit
      redirect_to books_path, :notice => "You are not allowed to edit the " +
      "books that have been added by others."
    end

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    if !@can_edit
      redirect_to books_path, :notice => "You are not allowed to edit the " +
      "books that have been added by others."
    end
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
end
