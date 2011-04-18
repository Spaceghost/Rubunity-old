class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user, :admin?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :notice => exception.message
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    Rails.logger.info("=====#{exception.inspect}=====")
    redirect_to :back, :notice => "Sorry. You have already Registered for this event."
  end
  
  
  private
  
  def admin?
    current_user && current_user.role?('admin')
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      redirect_to new_user_session_url, :notice => "You must be logged in to access this page"
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_back_or_default(root_url)
      return false
    end
  end

  def access_denied
    store_location
    redirect_to login_path
  end

  def require_login
    current_user || access_denied
  end

  def admin_access_denied
    flash[:warning] = "You have insuffcient access for the area you requested."
    redirect_back_or_default("/")
  end
  
  def require_admin
    #require_login
    admin? || admin_access_denied
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def url_lookup(url)
    @valid_responses = ["200", "301"]
    
	  @curl = %x{ curl -s --connect-timeout 3 -I #{url} --user-agent "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_1; en-us) AppleWebKit/531.9 (KHTML, like Gecko) Version/4.0.3 Safari/531.9" | grep HTTP }
	  
    if @valid_responses.include?(@curl[/\d\d\d/])
      return true
    else
      return false
    end
	end
end
