class BookclubsController < ApplicationController
  before_action :set_bookclub, only: %i[show edit update destroy]

  def index
    @bookclub = Bookclub.all
  end

  def show
  end

  def new
    @bookclub = Bookclub.new
  end

  def create
    @bookclub = Bookclub.new(book_params)
    if @bookclub.save
      redirect_to @bookclub
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @bookclub.update(bookclub_params)
      redirect_to @bookclub
    else
      render 'edit'
    end
  end

  def destroy
    @bookclub.destroy
    redirect_to bookclubs_path
  end

  private

  def book_params
    params.require(:bookclub).permit(:name, :description, :privacy)
  end

  def set_bookclub
    @bookclub = Bookclub.find(params[:id])
  end
end
