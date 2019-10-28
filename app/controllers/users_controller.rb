class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user,{only: [:edit, :update]}

  def new
  	@user =User.new
  end
  def index
  	@user = current_user
  	@users = User.all
  	@book = Book.new
  end

  def create
  	@users = User.new(user_params)
    @users.save
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	# @books = Book.where(user_id: @user.id)
  	@book = Book.new

  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "Book was successfully updated"
        redirect_to user_path(current_user)
    else
      render template: "users/edit"
    end
  end

  private
    def user_params
    	params.require(:user).permit(:name,:profile_image, :introduction)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if current_user != @user
        redirect_to user_path(current_user)
      end
    end
end
