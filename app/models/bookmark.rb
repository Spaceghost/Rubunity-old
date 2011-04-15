class Bookmark < ActiveRecord::Base
  make_voteable
  
  belongs_to :user
  has_many :comments, :as => :commentable
  after_create :generate_permalink

  acts_as_taggable 
  acts_as_taggable_on :ruby_versions, :rails_versions, :topics
                    
  has_many :flags, :as => :flaggable
  
  validates_uniqueness_of :url
  validates :title, :url, :presence => true
 
  define_index do
    # fields
    indexes title, :sortable => true
    indexes description
    #indexes comments.body
    indexes ruby_versions.name, :as => :ruby_versions
    indexes rails_versions.name, :as => :rails_versions
    indexes topics.name, :as => :topic
    indexes user.nickname, :as => :author, :sortable => true

    # attributes
    has permalink, url, user_id, created_at, updated_at
  end
 
  def self.per_page
    5
  end
  
  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
    
    def generate_permalink
      update_attributes(:permalink => "#{self.id}-#{self.title.parameterize}") 
    end
end
