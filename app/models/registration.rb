class Registration < ActiveRecord::Base
  validates_uniqueness_of :user_id,:scope => :event_id, :message => "You've already registered."
  belongs_to :user
  belongs_to :event
end
