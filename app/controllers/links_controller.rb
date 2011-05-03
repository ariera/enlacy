class LinksController < ApplicationController
  def index
    user=User.find_by_login(params[:login]) || User.first
    @links= user.links
  end
end
