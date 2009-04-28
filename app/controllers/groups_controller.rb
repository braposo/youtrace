class GroupsController < ApplicationController
  layout 'logged'
  before_filter :login_required
  before_filter :populate_sidebar, :except => ['new','create', 'join', 'leave']
  
  # GET /groups
  # GET /groups.xml
  def index
    redirect_to social_url
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = active_group    
    @events = @group.get_all_events
    @title = "#{@group.name} group |"
    
    @actions << 'delete_group' if @group.is_owned_by? current_user
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    add_breadcrumb "Social", social_path()
    add_breadcrumb "Create group"
    
    @group = Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = Group.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = Group.new(params[:group])
    @group.users << current_user
    
    respond_to do |format|
      if @group.save
        @group.groups_users.first.update_attribute :level, 2
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to(@group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = Group.find(params[:id])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to(@group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
  
  def info
    @group = active_group
    add_breadcrumb @group.name, group_path(@group)
    add_breadcrumb "Profile"
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end
  
  def members
    @group = active_group
    add_breadcrumb @group.name, group_path(@group)
    add_breadcrumb "Members"
    
    @members = @group.users
    
    respond_to do |format|
      format.html
      format.xml  { render :xml => @members.to_xml }
    end
  end
  
  def traces
    @group = active_group
    add_breadcrumb @group.name, group_path(@group)
    add_breadcrumb "Traces"
    
    @traces = @group.traces
  end
  
  def join
    @group = active_group
    @group.users << current_user
    
    flash[:notice] = "Group #{@group.name} subscribed!"
    redirect_back_or_default(group_path(@group))
  end
  
  def leave
    @group = active_group
    @user = params[:user_id] || current_user
    @group.users.delete @user
    
    flash[:notice] = "Group #{@group.name} unsubscribed!"
    redirect_back_or_default(user_network_path(@user))
  end
  
  private 
  def active_group
      @active_group ||= Group.find_by_id(params[:id]) unless @active_group == false
  end
  
  def populate_sidebar
    @sidebar = []
    @sidebar << 'create_group' if logged_in?
    @sidebar << 'join_group' if !current_user.in_group?(params[:id])
  end
end
