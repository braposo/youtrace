class UsersController < ApplicationController
  layout 'logged', :except => ['new','create', 'activate', 'subscribe']
  before_filter :login_required, :except => ['new','create', 'activate', 'subscribe']
  before_filter :populate_sidebar, :except => ['new','create', 'activate', 'subscribe']
  before_filter :populate_tips, :except => ['new','create', 'activate', 'subscribe']

  # render new.rhtml
  def new
    @user = User.new
    render :layout => 'main'
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please make shure that all fields are valid."
      redirect_back_or_default(signup_path)
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
    add_breadcrumb active_user.login, user_path(@user)
    add_breadcrumb "Dashboard"
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
      format.kml { render :text => "lol" }
    end
    
  end
  
  # GET /users/login/edit
  def edit
    @user = active_user
    add_breadcrumb active_user.login, user_path(@user)
    add_breadcrumb "Info", user_info_path(@user)
    add_breadcrumb "Edit"
    
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
        format.html { redirect_to(user_info_path(@user)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def network
    @user = active_user
    add_breadcrumb active_user.login, user_path(@user)
    add_breadcrumb "Network"
    
    @subscriptions = @user.authorized_subscriptions
    @followers = @user.authorized_followers
    @groups = @user.groups
    @pending_reqs = @user.pending_requests
    @pending_subs = @user.pending_subscriptions
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @subscriptions.to_xml }
    end
  end
  
  def traces
    active_user
    add_breadcrumb active_user.login, user_path(active_user)
    add_breadcrumb "Traces"
  end
  
  def info
    @user = active_user
    add_breadcrumb active_user.login, user_path(@user)
    add_breadcrumb "Profile"
    
    @tips << 'edit_profile' if current_user.login == params[:id]
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
    end
  end
  
  def prefs
    add_breadcrumb active_user.login, user_path(active_user)
    add_breadcrumb "Preferences"
  end
  
  def subscribe
    current_user.request_subscription(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} subscribed!"
    redirect_back_or_default(user_path(current_user))
  end
  
  def unsubscribe
    current_user.remove_subscription(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} unsubscribed!"
    redirect_back_or_default(user_network_path(current_user))
  end
  
  def authorize
    current_user.authorize_follower(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} authorized!"
    redirect_back_or_default(user_network_path(current_user))
  end
  
  def pause
    current_user.pause_subscription(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} has been paused!"
    redirect_back_or_default(user_network_path(current_user))
  end
  
  def delete
    current_user.delete_subscription(params[:sub_id])
    flash[:notice] = "User #{params[:sub_id]} has been deleted!"
    redirect_back_or_default(user_network_path(current_user))
  end
  
  private 
  def active_user
      @active_user ||= User.find_by_login(params[:id]) unless @active_user == false
  end
  
  def populate_sidebar
    @sidebar = []
    @sidebar << 'create_group' if logged_in?
    @sidebar << 'subscribe_user' if (logged_in? && current_user.login != params[:id] && !current_user.is_following?(params[:id]))
  end
  
  def populate_tips
    @tips = []
    @tips << 'return_profile' if current_user.login != params[:id]
  end
end
