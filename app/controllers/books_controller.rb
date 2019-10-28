class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only: [:edit, :update]}

	def new
		@book =Book.new
    @book = current_user.books.build
	end

	def index
    @book =Book.new
    @books =Book.all
    @user = current_user
  end

  def create
    @book = current_user.books.build(book_params)
    @user = current_user
    if @book.save
      flash[:notice] = "Book was successfully  created"
        redirect_to book_path(@book.id)
    else
      @books = Book.all
      render template: "books/index"
    end
  end

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated"
        redirect_to book_path
    else
      render template: "books/edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

 private
    def book_params
        params.require(:book).permit(:title,:body)
    end

    def ensure_correct_user
      @book = Book.find(params[:id])
      if current_user != @book.user
        redirect_to books_path
      end
    end
end
