class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user account
    
    if user.role?(:admin)
      can :manage, :all
    else
      can :read, :all
      #can :create, Comment
      can :vote, Bookmark
    
      if user.role?(:moderator)
        can :manage, Bookmark
        can :add_topic, Bookmark
        can :add_rails_version, Bookmark
        can :add_ruby_version, Bookmark
        can :manage, Comment
      end
    
      if user.role?(:contributor)
        can :create, Bookmark
        can [:add_topic, :add_rails_version, :add_ruby_version], Bookmark, :user_id => user.id
        can :update, Bookmark do |bookmark|
          bookmark.try(:user) == user
        end
        can :create, @comment
        can :update, @comment, :user_id => user.id
      end
    end
  end
end
