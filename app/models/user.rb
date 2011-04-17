class User < ActiveRecord::Base
  make_voter
  has_many :events_users
  has_many :events, :through => :events_users
  has_many :comments

  acts_as_authentic
  
  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0 "} }

  ROLES = %w[admin moderator contributor]

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end
  
  def full_name
    [self.first_name, self.last_name].join(" ")
  end
  
  def profile_image(imgsize = nil)
    size = 20
    case imgsize 
      when 'large' then size = 100
      when 'medium' then size = 60
      when 'small' then size = 40
    end
    "http://www.gravatar.com/avatar/#{hash = Digest::MD5.hexdigest(email)}?size=#{size}"
  end
  
end
