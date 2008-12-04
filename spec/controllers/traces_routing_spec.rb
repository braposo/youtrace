require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TracesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "traces", :action => "index").should == "/traces"
    end
  
    it "should map #new" do
      route_for(:controller => "traces", :action => "new").should == "/traces/new"
    end
  
    it "should map #show" do
      route_for(:controller => "traces", :action => "show", :id => 1).should == "/traces/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "traces", :action => "edit", :id => 1).should == "/traces/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "traces", :action => "update", :id => 1).should == "/traces/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "traces", :action => "destroy", :id => 1).should == "/traces/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/traces").should == {:controller => "traces", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/traces/new").should == {:controller => "traces", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/traces").should == {:controller => "traces", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/traces/1").should == {:controller => "traces", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/traces/1/edit").should == {:controller => "traces", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/traces/1").should == {:controller => "traces", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/traces/1").should == {:controller => "traces", :action => "destroy", :id => "1"}
    end
  end
end
