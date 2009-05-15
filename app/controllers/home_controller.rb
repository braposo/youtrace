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
    @search = Tag.find :all
    
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
  
  def tag      
    @traces = Trace.tagged_with params[:tag], :on => :tags
    @users = []
    
    @title = params[:tag] +" | Tag |"
    
    @actions << "bookmark_tag" unless params[:tag].nil? || current_user.has_bookmark?(params[:tag])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traces }
    end
  end
  
  def search      
    @tags = Trace.tag_counts_on :tags
    @results = Trace.search(params[:q], { :per_page => 10, :page => params[:page] })
    
    @title = "Search |"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @traces }
    end
  end
  
  def tag_list
    @tags = Trace.tag_counts_on :tags, :conditions => "tags.name LIKE '%#{params[:tag]}%'", :limit => 10
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
    logged_in?? 'logged' : 'main'
  end
  
  def populate_sidebar
    @sidebar = []
    @sidebar << 'create_group' if logged_in?
  end
end
