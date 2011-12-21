class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def authorize
    unless user_signed_in?
      flash[:error] = "Unauthorized Access!"
      redirect_to root_path
      false
    end
  end
  
end
