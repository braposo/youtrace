ActionController::Routing::Routes.draw do |map|
  map.resources :users, :sessions
  map.resources :traces
  map.resources :groups

  map.root :controller => "home"
  
  #Main navigation
  map.map '/map', :controller => 'home', :action => 'map'
  map.social '/social', :controller => 'home', :action => 'social'
  map.howto '/howto', :controller => 'home', :action => 'howto'
  map.about '/about', :controller => 'home', :action => 'about'
  
  #User authentication
  map.logout '/account/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/account/login', :controller => 'sessions', :action => 'new'
  map.signup '/account/signup', :controller => 'users', :action => 'new'
  map.activate '/account/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
  
  #User navigation
  #map.user '/:user', :controller => 'users', :action => 'show'
  #map.connect '/:user.:format', :controller => 'users', :action => 'show'
  #map.user_map '/:user/map', :controller => 'users', :action => 'map'
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
