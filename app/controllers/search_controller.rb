class SearchController < ApplicationController
  
  def query
    logger.debug "!!!!!!!!!!!!!!!!!!!! blah"
    if params[:q]
      if params[:q].include? "comments:"
        @params = params[:q].split(':')
        @type = @params[0]
        @query = @params[1]
        @results = Comment.search @query, :star => true, :page => params[:page], :per_page => 20
      elsif params[:q].include? "tags:"
        @results = ThinkingSphinx.search params[:q], :page => params[:page], :per_page => 20
      else
        @results = ThinkingSphinx.search params[:q], :page => params[:page], :per_page => 20
      end
    end
    
    render :template => 'search/results'
  end
  
  def index
    @bookmarks = Bookmark.find(:all, :limit => 12, :order => 'created_at DESC')
    #@results = ThinkingSphinx.search params[:query]
    render :layout => 'front'
  end
end
