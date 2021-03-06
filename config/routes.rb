ActionController::Routing::Routes.draw do |map|
  map.resource :sessions
  map.resources :events
  map.resources :traces
      
  map.resources :groups do |groups|
    groups.home 'home', :controller => 'groups', :action => 'home', :path_prefix => '/groups/:id'
    groups.members 'members', :controller => 'groups', :action => 'members', :path_prefix => '/groups/:id'
    groups.traces 'traces', :controller => 'groups', :action => 'traces', :path_prefix => '/groups/:id'
    groups.info 'info', :controller => 'groups', :action => 'info', :path_prefix => '/groups/:id'
    groups.prefs 'prefs', :controller => 'groups', :action => 'prefs', :path_prefix => '/groups/:id'
    groups.join 'join', :controller => 'groups', :action => 'join', :path_prefix => '/groups/:id'
    groups.leave 'leave', :controller => 'groups', :action => 'leave', :path_prefix => '/groups/:id'
  end
  
  #User navigation
  map.resources :users, :member => { :crop => :post } do |users|
    users.home 'home', :controller => 'users', :action => 'home', :path_prefix => '/users/:id'
    users.bookmarks 'bookmarks', :controller => 'users', :action => 'bookmarks', :path_prefix => '/users/:id'
    users.traces 'traces', :controller => 'users', :action => 'traces', :path_prefix => '/users/:id'
    users.info 'info', :controller => 'users', :action => 'info', :path_prefix => '/users/:id'
    users.prefs 'prefs', :controller => 'users', :action => 'prefs', :path_prefix => '/users/:id'
    users.bookmark_user 'bookmark_user/:sub_id', :controller => 'users', :action => 'bookmark_user', :path_prefix => '/users/:id'
    users.delete 'delete/:sub_id', :controller => 'users', :action => 'delete_profile', :path_prefix => '/users/:id'
    users.authorize 'authorize/:sub_id', :controller => 'users', :action => 'authorize', :path_prefix => '/users/:id'
    users.pause 'pause/:sub_id', :controller => 'users', :action => 'pause', :path_prefix => '/users/:id'
    users.bookmark_tag 'bookmark_tag/:tags', :controller => 'users', :action => 'bookmark_tag', :path_prefix => '/users/:id'
    users.delete_tag 'delete_tag/:tags', :controller => 'users', :action => 'delete_tag', :path_prefix => '/users/:id'
  end
  
  map.root :controller => "home"
  
  #Main navigation
  map.map '/map', :controller => 'home', :action => 'map'
  map.social '/social', :controller => 'home', :action => 'social'
  map.howto '/howto', :controller => 'home', :action => 'howto'
  map.about '/about', :controller => 'home', :action => 'about'
  map.tag '/tag/:tag', :controller => 'home', :action => 'tag'
  map.tag_list '/tag_list', :controller => 'home', :action => 'tag_list'
  map.search '/search', :controller => 'home', :action => 'search'
  
  #User authentication
  map.logout '/account/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/account/login', :controller => 'sessions', :action => 'new'
  map.signup '/account/signup', :controller => 'users', :action => 'new'
  map.activate '/account/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  
  #User navigation
  #map.user '/:user', :controller => 'users', :action => 'show'
  #map.connect '/:user.:format', :controller => 'users', :action => 'show'
#  map.user_home '/users/:id/home', :controller => 'users', :action => 'home'
#  map.user_social '/users/:id/social', :controller => 'users', :action => 'social'
#  map.user_traces '/users/:id/traces', :controller => 'users', :action => 'traces'
#  map.user_info '/users/:id/info', :controller => 'users', :action => 'info'
#  map.user_prefs '/users/:id/prefs', :controller => 'users', :action => 'prefs'
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
