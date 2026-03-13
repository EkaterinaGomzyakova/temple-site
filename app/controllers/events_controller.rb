class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def index
    @events = Event.all
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    @event = Event.new(event_params)
    @event.created_by = current_user # если есть аутентификация

    if @event.save
      redirect_to @event, notice: "Событие успешно создано."
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Событие обновлено."
    else
      render :edit
    end
  end

  def destroy
    @event.update(deleted_at: Time.current)
    redirect_to events_url, notice: "Событие удалено."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :cover_image, :start_time, :location,
      :price, :capacity, :event_type, :club_id, :is_published, :slug,
      images: [] # для галереи изображений
    )
  end
end