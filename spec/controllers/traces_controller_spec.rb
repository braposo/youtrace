require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TracesController do

  def mock_trace(stubs={})
    @mock_trace ||= mock_model(Trace, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all traces as @traces" do
      Trace.should_receive(:find).with(:all).and_return([mock_trace])
      get :index
      assigns[:traces].should == [mock_trace]
    end

    describe "with mime type of xml" do
  
      it "should render all traces as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Trace.should_receive(:find).with(:all).and_return(traces = mock("Array of Traces"))
        traces.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested trace as @trace" do
      Trace.should_receive(:find).with("37").and_return(mock_trace)
      get :show, :id => "37"
      assigns[:trace].should equal(mock_trace)
    end
    
    describe "with mime type of xml" do

      it "should render the requested trace as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Trace.should_receive(:find).with("37").and_return(mock_trace)
        mock_trace.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new trace as @trace" do
      Trace.should_receive(:new).and_return(mock_trace)
      get :new
      assigns[:trace].should equal(mock_trace)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested trace as @trace" do
      Trace.should_receive(:find).with("37").and_return(mock_trace)
      get :edit, :id => "37"
      assigns[:trace].should equal(mock_trace)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created trace as @trace" do
        Trace.should_receive(:new).with({'these' => 'params'}).and_return(mock_trace(:save => true))
        post :create, :trace => {:these => 'params'}
        assigns(:trace).should equal(mock_trace)
      end

      it "should redirect to the created trace" do
        Trace.stub!(:new).and_return(mock_trace(:save => true))
        post :create, :trace => {}
        response.should redirect_to(trace_url(mock_trace))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved trace as @trace" do
        Trace.stub!(:new).with({'these' => 'params'}).and_return(mock_trace(:save => false))
        post :create, :trace => {:these => 'params'}
        assigns(:trace).should equal(mock_trace)
      end

      it "should re-render the 'new' template" do
        Trace.stub!(:new).and_return(mock_trace(:save => false))
        post :create, :trace => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested trace" do
        Trace.should_receive(:find).with("37").and_return(mock_trace)
        mock_trace.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :trace => {:these => 'params'}
      end

      it "should expose the requested trace as @trace" do
        Trace.stub!(:find).and_return(mock_trace(:update_attributes => true))
        put :update, :id => "1"
        assigns(:trace).should equal(mock_trace)
      end

      it "should redirect to the trace" do
        Trace.stub!(:find).and_return(mock_trace(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(trace_url(mock_trace))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested trace" do
        Trace.should_receive(:find).with("37").and_return(mock_trace)
        mock_trace.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :trace => {:these => 'params'}
      end

      it "should expose the trace as @trace" do
        Trace.stub!(:find).and_return(mock_trace(:update_attributes => false))
        put :update, :id => "1"
        assigns(:trace).should equal(mock_trace)
      end

      it "should re-render the 'edit' template" do
        Trace.stub!(:find).and_return(mock_trace(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested trace" do
      Trace.should_receive(:find).with("37").and_return(mock_trace)
      mock_trace.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the traces list" do
      Trace.stub!(:find).and_return(mock_trace(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(traces_url)
    end

  end

end
