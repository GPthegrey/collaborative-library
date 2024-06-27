class BookclubsController < ApplicationController
  before_action :set_bookclub, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @bookclubs = Bookclub.all
    @member = Member.new

  end

  def show
    @member = Member.new
  end

  def new
    @bookclub = Bookclub.new
  end

  def create
    @bookclub = Bookclub.new(bookclub_params)
    @bookclub.organizer_id = current_user.id

    if @bookclub.save
      redirect_to @bookclub, notice: 'Club de lectura creado correctamente'
    else
      render :new
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

  def bookclub_params
    params.require(:bookclub).permit(:name, :description, :location, :max_members, :privacy, :genre, :meeting_schedule)
  end

  def set_bookclub
    @bookclub = Bookclub.find(params[:id])
  end
end
