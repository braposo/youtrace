require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "events", :action => "index").should == "/events"
    end
  
    it "should map #new" do
      route_for(:controller => "events", :action => "new").should == "/events/new"
    end
  
    it "should map #show" do
      route_for(:controller => "events", :action => "show", :id => 1).should == "/events/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "events", :action => "edit", :id => 1).should == "/events/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "events", :action => "update", :id => 1).should == "/events/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "events", :action => "destroy", :id => 1).should == "/events/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/events").should == {:controller => "events", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/events/new").should == {:controller => "events", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/events").should == {:controller => "events", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/events/1").should == {:controller => "events", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/events/1/edit").should == {:controller => "events", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/events/1").should == {:controller => "events", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/events/1").should == {:controller => "events", :action => "destroy", :id => "1"}
    end
  end
end
