class MembersController < ApplicationController

  def create
    @bookclub = Bookclub.find(params[:bookclub_id])
    if @bookclub.organizer_id == current_user.id
      redirect_to @bookclub, notice: 'No puedes unirte a tu propio club de lectura'
    else
      @member = Member.new(user_id: current_user.id, bookclub_id: @bookclub.id)
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
    redirect_to bookclubs_path
  end


end
