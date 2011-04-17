class EventsController < ApplicationController

  def index
     @events = Event.where("event_date >=?", Time.now)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(params[:event])

    if @event.save
      redirect_to events_url, :notice => "Event: #{@event.topic} has been created."
    else
      render :new
    end
  end

  def show
    @event = find_event(params[:id])
  end

  def sign_up
    event = Event.find_by_permalink(params[:event_id])

    event.users << current_user
    if event.save
      redirect_to events_url, :notice => "You have successfully signed up for this event." and return
    else
      redirect_to register_url, :notice => "You have either already signed up for this event or are not logged in."
    end
  end

  private

  def find_event(event_id)
    Event.find_by_permalink(event_id)
  end
end
