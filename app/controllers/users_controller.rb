class UsersController < ApplicationController
  layout 'logged', :except => ['new','create', 'activate', 'subscribe']
  before_filter :login_required, :except => ['new','create', 'activate', 'subscribe']
  before_filter :populate_actions, :except => ['new','create', 'activate', 'subscribe']
  before_filter :populate_tips, :except => ['new','create', 'activate', 'subscribe']
  before_filter :owner_required, :only => ['edit', 'bookmark', 'traces', 'info']

  # render new.rhtml
  def new
    @user = User.new
    @title = "Sign up |"
    render :layout => 'main'
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    @user.activated_at = Time.now.utc
    @title = "Sign up |"
    success = @user && @user.save
    respond_to do |format|
      if success && @user.errors.empty?
        flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
        format.html { redirect_to root_path }
      else
        flash[:error]  = "We couldn't set up that account, sorry.  Please make shure that all fields are valid."
        format.html { render :action => "new", :layout => 'main' }
      end
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to login_path
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end
  
  def show    
    @user = active_user 
    @events = @user.get_all_events(params[:page])
    @title = "Dashboard |"
    
    if (current_user.login != params[:id]) 
       @actions << 'bookmark_user' if !current_user.is_following?(params[:id])
       @events = @user.get_all_messages
       @title = "#{@user.login} profile |"
       @traces = @user.traces
    end
      
    respond_to do |format|
      if (current_user.login != params[:id])
        format.html { render :action => 'profile' }
      elsif !params[:type].nil?
        format.html { render :template => 'events/events.html.erb', :layout => false }
      else 
        format.html { }
      end
      
      format.xml  { render :xml => @user.to_xml }
      format.kml { render :text => "lol" }
      format.js { render :template => 'events/events.html.erb', :layout => false }
    end
    
  end
  
  # GET /users/login/edit
  def edit
    @user = active_user
    @title = "Edit Profile | #{@user.login} |"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  # PUT /users/login
  # PUT /users/login.xml
  def update
    @user = User.find_by_login(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Your profile was successfully updated.'
        if params[:user][:photo].blank?
          format.html { redirect_to(user_info_path(@user)) }
          format.xml  { head :ok }
        else
          format.html { render :action => 'cropping' } 
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def bookmarks
    @user = active_user
    
    @profiles = @user.authorized_users + @user.bookmarks
    @followers = @user.authorized_followers
    @pending_reqs = @user.pending_requests
    @pending_subs = @user.pending_bookmarks
    
    @title = "My Bookmarks |"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @subscriptions.to_xml }
    end
  end
  
  def traces
    @user = current_user
    @traces = @user.traces.find :all, :order => "created_at DESC"
    
    @title = "My Map |"
    respond_to do |format|
      format.html
      format.xml  { render :xml => @traces.to_xml }
    end
  end
  
  def info
    @user = active_user
    @actions << 'edit_profile' if current_user.login == params[:id]
    @title = "My Profile |"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  def profile
    
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  def prefs
    add_breadcrumb active_user.login, user_path(active_user)
    add_breadcrumb "Preferences"
  end
  
  def bookmark_user
    current_user.request_bookmark(params[:sub_id])
    flash[:notice] = "Request sent to #{params[:sub_id]}"
    redirect_back_or_default(user_bookmarks_path(current_user))
  end
  
  def bookmark_tag
    current_user.bookmark_tag(params[:tags])
    flash[:notice] = "<strong>#{params[:tags]}</strong> tag added to bookmarks"
    redirect_back_or_default(user_bookmarks_path(current_user))
  end
  
  def delete_profile
    current_user.delete_profile(params[:sub_id])
    flash[:notice] = "#{params[:sub_id]} removed from your bookmarks"
    redirect_to(user_bookmarks_path(current_user))
  end
  
  def delete_tag
    current_user.delete_search(params[:tags])
    flash[:notice] = "#{params[:tags]} tag removed from your bookmarks"
    redirect_to(user_bookmarks_path(current_user))
  end
  
  def authorize
    current_user.authorize_follower(params[:sub_id])
    flash[:notice] = "#{params[:sub_id]} is now receiving your updates. "
    flash[:notice] += " Why don't you <a href=#{ user_bookmark_user_path(:id => current_user, :sub_id => params[:sub_id]) }>send a request</a> too?" unless current_user.is_following?(params[:sub_id])
    redirect_to(user_bookmarks_path(current_user))
  end
  
  def pause
    current_user.pause_subscription(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} has been paused!"
    redirect_back_or_default(user_network_path(current_user))
  end
  
  # POST /users/1/crop
  def crop
    @user = User.find_by_login(params[:id])

    if @user.update_attributes(params[:user])
      @user.photo.reprocess!
    end
    
    redirect_to(user_info_path(@user))
  end
  
  def cropping
  end
  
  private 
  def active_user
      @active_user ||= User.find_by_login(params[:id]) unless @active_user == false
  end
  
  def populate_actions
    get_actions
    @actions << 'bookmark_user' if (logged_in? && current_user.login != params[:id] && !current_user.is_following?(params[:id]))
  end
  
  def populate_tips
    @tips = []
    #@tips << 'return_profile' if current_user.login != params[:id]
  end
  
  def owner_required
    (current_user.login == params[:id]) || access_owner
  end
end
