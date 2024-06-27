class AssistancesController < ApplicationController

  before_action :set_event, only: %i[create]

  def create
    if @event.organizer_id == current_user.id
      redirect_to @event, notice: 'No puedes unirte a tu propio club de lectura'
    else
      @assistance = @event.assistances.new(user_id: current_user.id)
      if @assistance.save
        redirect_to @event, notice: 'Asistiras al evento literario'
      else
        redirect_to @event, notice: 'No te has podido unir al evento literario'
      end
    end
  end

  def destroy
    @assistance = Assistance.find(params[:id])
    @assistance.destroy
    redirect_to events_path, notice: 'No asistiras al evento literario'
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
