class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user account
     
    if user.role?(:admin)
      can :manage, :all
    else
      can :read, :all
      # cannot :create, Bookmark
      # can :vote, Bookmark

      if user.role?(:moderator)
        can :manage, :all
        can :add_topic, Bookmark
        can :remove_topic, Bookmark
        can :add_rails_version, Bookmark
        can :add_ruby_version, Bookmark
      end
    
      if user.role?(:contributor)
        can :create, Bookmark
        can [:add_topic, :add_rails_version, :add_ruby_version], Bookmark, :user_id => user.id
        can [:remove_topic, :remove_rails_version, :remove_ruby_version], Bookmark, :user_id => user.id
        can :update, Bookmark do |bookmark|
          bookmark.try(:user) == user
        end

        can [:create, :register, :unregister], Event
      end
    end
  end
end
