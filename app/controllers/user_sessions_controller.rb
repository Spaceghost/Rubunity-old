class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end
  
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_url, :notice => "Hello!"
    else
      redirect_to new_user_session_path, :notice => "Invlaid Credentials"
    end
  end
  

  def destroy
    @user_session = UserSession.find
    @user_session.destroy if @user_session
    flash[:notice] = "Goodbye!"
    redirect_to root_url
  end

end
