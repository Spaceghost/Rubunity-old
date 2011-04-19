class SearchController < ApplicationController
  
  def query
    logger.debug "!!!!!!!!!!!!!!!!!!!! blah"
    if params[:q]
      @results = ThinkingSphinx.search params[:q], :page => params[:page], :per_page => 20
    end
    
    render :template => 'search/results'
  end
  
  def index
    @bookmarks = Bookmark.find(:all, :limit => 12, :order => 'created_at DESC')
    #@results = ThinkingSphinx.search params[:query]
    render :layout => 'front'
  end
end
