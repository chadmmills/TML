class EventsController < ApplicationController
  def index
    render locals: {
      events: Event.upcoming.map { |e| EventDecorator.new(e) },
      previous_events: Event.in_the_past.map { |e| EventDecorator.new(e) },
      floating_events: Event.floating.map { |e| EventDecorator.new(e) },
    }
  end

  def show
    respond_to do |f|
      f.html { render locals: { event: event }}
      f.js { render locals: { event: event }}
    end
  end

  def new
    render locals: { event: Event.new }
  end

  def create
    if new_event.save
      redirect_to root_path
    end
  end

  private

  def event
    @_event ||= Event.find(params[:id])
  end

  def new_event
    @_event = Event.new(event_params)
  end

  def event_params
    params.require(:event).permit(:event_title, :event_date)
  end
end
