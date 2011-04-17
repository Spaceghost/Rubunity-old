class Registration < ActiveRecord::Base
  validates :user_id, :uniqueness => { :scope => :event_id }
  belongs_to :user
  belongs_to :event
end
