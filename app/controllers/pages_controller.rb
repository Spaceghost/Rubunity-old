class PagesController < ApplicationController
  layout :choose_layout
  
  def home
    @recent_bookmarks = Bookmark.all(:limit => 3)
  end
  
  def community
  end
  
  def irc_bot_usage
  end
  
  def choose_layout
    'home' unless action_name != 'home'
  end
end
