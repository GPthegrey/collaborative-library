class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to @review
    else
      render 'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
