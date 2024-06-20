class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user_reviewer_id = current_user.id
    loan = Loan.find(review_params[:loan_id])
    users = [loan.owner_id, loan.borrower_id]
    reviewed_id = users.reject { |user_id| user_id == current_user.id }.first
    @review.user_reviewed_id = reviewed_id
    if @review.save
      redirect_to loan_path(loan)
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :loan_id, :user_reviewed_id)
  end
end
