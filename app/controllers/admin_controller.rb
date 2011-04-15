class AdminController < ApplicationController

  before_filter :require_user
  before_filter :require_admin

  def index
    @users = User.all
  end
end
