class BookmarksController < ApplicationController
  load_and_authorize_resource
  
  before_filter :require_user, :except => [:index, :show]
  
  def index
    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmarks }
    end
  end

  def show
    @url_status = url_lookup(@bookmark.url)
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmark }
    end
  end

  def new
    @bookmark = Bookmark.new
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @bookmark }
    end
  end

  def edit
  end

  def create
    @bookmark = Bookmark.new(params[:bookmark])
    @bookmark.user_id = current_user.id
    
    respond_to do |format|
      if @bookmark.save
        format.html { redirect_to(@bookmark, :notice => 'Bookmark was successfully created.') }
        format.xml  { render :xml => @bookmark, :status => :created, :location => @bookmark }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bookmark.update_attributes(params[:bookmark])
        format.html { redirect_to(@bookmark, :notice => 'Bookmark was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_topic
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])
    
    @topics = []
    
    @bookmark.topic_list.each do |topic|
      @topics << topic
    end
    
    params[:topic].split(%r{,\s*}).each do |topic|
      @topics << topic
      @topics.uniq
    end
    
    @topics.each do |topic|
      @bookmark.topic_list.add(topic)
    end
        
    respond_to do |format|
      if @bookmark.save
        format.js
      else
        flash[:notice] = "You can not add topics."
      end
    end
  end
  
  def remove_topic
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])
    
    @bookmark.topic_list.remove(params[:remove_topic])
    
    respond_to do |format|
      if @bookmark.save
        render :nothing => true
      else
        flash[:notice] = "You can not remove topics."
      end
    end
  end
  
  def add_rails_version
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])
    
    @versions = []
    
    @bookmark.rails_version_list.each do |version|
      @versions << version
    end
    
    params[:rails_versions].each do |version|
      @versions << version
      @versions.uniq
    end
    
    @versions.each do |version|
      @bookmark.rails_version_list.add(version)
    end
        
    respond_to do |format|
      if @bookmark.save
        format.js
      end
    end
  end
  
  def remove_rails_version
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])
    
    @bookmark.rails_version_list.remove(params[:remove_rails_version])
    
    respond_to do |format|
      if @bookmark.save
        render :nothing => true
      else
        flash[:notice] = "You can not remove Rails versions."
      end
    end
  end
  
  def add_ruby_version
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])

    params[:ruby_version].to_s.split(%r{,\s*}).each do |ruby_version|
      @bookmark.ruby_version_list.add(ruby_version)
    end
        
    respond_to do |format|
      if @bookmark.save
        format.js
      end
    end
  end
  
  def remove_ruby_version
    @bookmark = Bookmark.find_by_permalink(params[:bookmark_id])
    
    @bookmark.ruby_version_list.remove(params[:remove_ruby_version])
    
    respond_to do |format|
      if @bookmark.save
        render :nothing => true
      else
        flash[:notice] = "You can not remove Ruby versions."
      end
    end
  end

  def destroy
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_to(bookmarks_url) }
      format.xml  { head :ok }
    end
  end
  
  def vote
    b = Bookmark.find_by_id(params[:bookmark])
    if !current_user || b.user_id == current_user.id || current_user.voted?(b)
      redirect_to :back, :alert => "Sorry, no can do." and return
    else
      current_user.up_vote(b)
      redirect_to :back, :notice => "Thank's for your vote!"
    end
  end
end
