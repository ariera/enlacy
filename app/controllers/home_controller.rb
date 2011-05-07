class HomeController < ApplicationController
  def index
    redirect_to home_path(current_user) if user_signed_in?
  end
end
