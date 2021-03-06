class LinksController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def index
    @user=User.find_by_login(params[:login]) || User.first
    @main_links= @user.main_links
    @working_links= @user.working_links
  end
  
  def create
    link = Link.new(params[:link])
    current_user.links << link
    flash[:alert] = link.errors[:base]
    redirect_to home_path(current_user)
  end
  
  def sort
    if params[:collection] == 'main_links'
      links = current_user.main_links
    elsif params[:collection] == 'working_links'
      links = current_user.working_links
    end
    
    links.each do |link|
      link.position = params['link'].index(link.id.to_s)
      link.save
    end
    render :nothing => true
  end
  
  def destroy
    render :text => params[:id]
  end
end
