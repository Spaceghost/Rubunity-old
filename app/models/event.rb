class Event < ActiveRecord::Base
  has_many :registrations
  has_many :users, :through => :registrations

  after_create :generate_permalink

  
  def to_param
    "#{id}-#{speaker.downcase.gsub(/[^a-z0-9]+/i, '-')}-#{topic.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def verify_event(current_user)
    self.users.exists?(current_user)
  end

  def full?
    available_slots <= 0
  end

  def available_slots
    seat_count - users.size
  end

  private
    def generate_permalink
      update_attributes(:permalink => "#{self.speaker.downcase.parameterize}-#{self.topic.downcase.parameterize}")
    end
end
