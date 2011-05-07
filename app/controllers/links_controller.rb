class LinksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @user=User.find_by_login(params[:login]) || User.first
    @links= @user.links
  end
  
  def create
    link = Link.new(params[:link])
    link.title = link.url
    current_user.links << link
    redirect_to home_path(current_user)
  end
  
  def sort
    links = current_user.links
    links.each do |link|
      link.position = params['link'].index(link.id.to_s) + 1
      link.save
    end
    redirect_to home_path(current_user)
  end
  
  def destroy
    render :text => params[:id]
  end
end
