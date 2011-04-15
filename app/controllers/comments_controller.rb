class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @commentable = find_commentable
    @comments = @commentable.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @comments }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @comment }
    end
  end

  def new
    @commentable = commentable
    @comment = commentable.comments.build

    respond_to do |format|
      format.html
      format.xml  { render :xml => @comment }
    end
  end

  def edit
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(params[:comment].merge!(:user_id => current_user.id))

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@commentable, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end

private
  
  def find_commentable
    params.each do |name,value|
      if name=~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end 
  end
end
