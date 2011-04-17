class Event < ActiveRecord::Base
  has_many :events_users
  has_many :users, :through => :events_users

  after_create :generate_permalink

  
  def to_param
    "#{speaker.downcase.gsub(/[^a-z0-9]+/i, '-')}-#{topic.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
  
  def verify_event
    
  end

  private
    def generate_permalink
      update_attributes(:permalink => "#{self.speaker.downcase.parameterize}-#{self.topic.downcase.parameterize}")
    end
end
