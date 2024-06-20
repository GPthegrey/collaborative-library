class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = Book.where(user: @user)
    @reviews = Review.where(user_reviewed_id: @user.id)
    @rating = Review.where(user_reviewed_id: @user.id).average(:rating)
  end

  def profile
    @user = current_user
    @books = Book.where(user: @user)
    @loans = Loan.where(borrower_id: @user.id)
    @reviews = Review.where(user_reviewed_id: @user.id)
    @rating = Review.where(user_reviewed_id: @user.id).average(:rating)
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      sign_in(@user) # Sign in the user after successful registration
      redirect_to items_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :address, :nickname)
  end
end
