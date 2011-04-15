class Conference < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  after_create :generate_permalink
  
  def to_param
    "#{speaker.downcase.gsub(/[^a-z0-9]+/i, '-')}-#{name.downcase.gsub(/[^a-z0-9]+/i, '-')}"
  end
    
  private
    def generate_permalink
      update_attributes(:permalink => "#{self.speaker.downcase.parameterize}-#{self.name.downcase.parameterize}") 
    end
end
