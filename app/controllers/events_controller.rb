class EventsController < ApplicationController
  load_and_authorize_resource

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
    @event = Event.find(params[:id])
  end

  def register
    event = Event.find(params[:event_id])
    if current_user 
      event.users << current_user
      redirect_to :back, :notice => "You have successfully signed up for this event." and return
    else
      redirect_to login_url, :notice => "You must be a member of the Rubunity community to register for an event."
    end
  end
  
  def unregister
    event = Event.find(params[:event_id])

    event.users.delete current_user
    if event.save
      redirect_to :back, :notice => "You have successfully un-signed up for this event." and return
    else
      redirect_to register_url, :notice => "You have either already un-signed up for this event or are not logged in."
    end
  end

  private

  def find_event(event_id)
    Event.find_by_permalink(event_id)
  end
end
