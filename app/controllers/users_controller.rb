class UsersController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :edit, :destroy]
  before_filter :ensure_not_logged_in, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :settings] 
  
  def index
    @users = User.all
  end

  def show
    @user = current_user
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def settings
    if !current_user
      redirect_to root_url
      return false
    end
    @user = current_user
  end
  
  
  def create    
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => 'Welcome!'
    else
      render :action => "new"
    end
  end
  
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_url, :notice => 'Profile updated!'
    else
      render :action => "edit"
    end
  end
  
 def choose_layout
   case action_name
    when 'home' then 'home'
    else 'content'
  end
 end

  private
  
  def ensure_not_logged_in
    if current_user
      redirect_to root_url
      return false
    end
  end
  
end
