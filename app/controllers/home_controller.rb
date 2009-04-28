class HomeController < ApplicationController
  layout :get_layout
  before_filter :populate_sidebar
  
  def index
    @title = "Home |"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def map
    @title = "World Map |"
  end

  def social
    @title = "Profiles |"
    
    @users = User.find :all, :conditions => "activated_at IS NOT NULL"
    @groups = Group.find :all, :conditions => "privacy < 2"
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @accounts }
    end
  end

  def howto
    @title = "How to |"
  end

  def about
    @title = "About us |"
  end
  
  def search      
    @traces = Trace.tagged_with params[:tag], :on => :tags
    @users = []
    
    @title = "Search |"
    
    @actions << "bookmark_search" unless params[:tag].nil? || current_user.has_bookmark?(params[:tag])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traces }
    end
  end
  
  def tag_list
    @tags = Tag.find :all, :conditions => "name LIKE '%#{params[:tag]}%'"
    @list = []
    
    for t in @tags 
      @list << t.name
    end
    
    respond_to do |format|
      format.html { render :json => @list.to_json}
    end
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
