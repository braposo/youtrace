class HomeController < ApplicationController
  layout :get_layout
  before_filter :populate_sidebar
  
  def index
    add_breadcrumb "Home"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def map
    add_breadcrumb "Map"
  end

  def social
    add_breadcrumb "Social"
    @users = User.find :all, :conditions => "activated_at IS NOT NULL"
    @groups = Group.find :all, :conditions => "privacy < 2"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def howto
    add_breadcrumb "How to"
  end

  def about
    add_breadcrumb "About"
  end
  
  private
  def get_layout
    logged_in? ? 'logged' : 'main'
  end
  
  def populate_sidebar
    @sidebar = []
    @sidebar << 'create_group' if logged_in?
  end
end
