class MembersController < ApplicationController
  before_action :set_bookclub, only: %i[create]

  def create
    if @bookclub.organizer_id == current_user.id
      redirect_to @bookclub, notice: 'No puedes unirte a tu propio club de lectura'
    else
      @member = @bookclub.members.new(user_id: current_user.id)
      if @member.save
        redirect_to @bookclub, notice: 'Te has unido al club de lectura'
      else
        redirect_to @bookclub, notice: 'No te has podido unir al club de lectura'
      end
    end
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to bookclubs_path, notice: 'Has abandonado el club de lectura'
  end

  private

  def set_bookclub
    @bookclub = Bookclub.find(params[:bookclub_id])
  end
end
