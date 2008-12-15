class HomeController < ApplicationController
  layout :get_layout
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def map
    
  end

  def social
    @users = User.find :all, :conditions => "activated_at IS NOT NULL"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def howto
  end

  def about
  end
  
  private
  def get_layout
    logged_in? ? 'logged' : 'main'
  end
end
