# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  before_filter :default_actions
  include AuthenticatedSystem

  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '05a7f77aae7bc8be7bc6eb8e22baa872'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def default_actions
    @actions = []
    @actions << 'add_trace' if logged_in?
    @actions << 'search' if logged_in?
  end
  
  def get_actions
    @actions
  end
  
  def access_owner
    respond_to do |format|
      format.html do
        flash[:error] = "You're not allowed to view this section. Redirected to user profile"
        redirect_to user_path(params[:id])
      end
    end
  end
  
  add_breadcrumb 'uTrace', '/'
end
