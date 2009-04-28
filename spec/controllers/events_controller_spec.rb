require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs)
  end
  
  describe "responding to GET index" do

    it "should expose all events as @events" do
      Event.should_receive(:find).with(:all).and_return([mock_event])
      get :index
      assigns[:events].should == [mock_event]
    end

    describe "with mime type of xml" do
  
      it "should render all events as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Event.should_receive(:find).with(:all).and_return(events = mock("Array of Events"))
        events.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "responding to GET show" do

    it "should expose the requested event as @event" do
      Event.should_receive(:find).with("37").and_return(mock_event)
      get :show, :id => "37"
      assigns[:event].should equal(mock_event)
    end
    
    describe "with mime type of xml" do

      it "should render the requested event as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "responding to GET new" do
  
    it "should expose a new event as @event" do
      Event.should_receive(:new).and_return(mock_event)
      get :new
      assigns[:event].should equal(mock_event)
    end

  end

  describe "responding to GET edit" do
  
    it "should expose the requested event as @event" do
      Event.should_receive(:find).with("37").and_return(mock_event)
      get :edit, :id => "37"
      assigns[:event].should equal(mock_event)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created event as @event" do
        Event.should_receive(:new).with({'these' => 'params'}).and_return(mock_event(:save => true))
        post :create, :event => {:these => 'params'}
        assigns(:event).should equal(mock_event)
      end

      it "should redirect to the created event" do
        Event.stub!(:new).and_return(mock_event(:save => true))
        post :create, :event => {}
        response.should redirect_to(event_url(mock_event))
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved event as @event" do
        Event.stub!(:new).with({'these' => 'params'}).and_return(mock_event(:save => false))
        post :create, :event => {:these => 'params'}
        assigns(:event).should equal(mock_event)
      end

      it "should re-render the 'new' template" do
        Event.stub!(:new).and_return(mock_event(:save => false))
        post :create, :event => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "responding to PUT udpate" do

    describe "with valid params" do

      it "should update the requested event" do
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :event => {:these => 'params'}
      end

      it "should expose the requested event as @event" do
        Event.stub!(:find).and_return(mock_event(:update_attributes => true))
        put :update, :id => "1"
        assigns(:event).should equal(mock_event)
      end

      it "should redirect to the event" do
        Event.stub!(:find).and_return(mock_event(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(event_url(mock_event))
      end

    end
    
    describe "with invalid params" do

      it "should update the requested event" do
        Event.should_receive(:find).with("37").and_return(mock_event)
        mock_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :event => {:these => 'params'}
      end

      it "should expose the event as @event" do
        Event.stub!(:find).and_return(mock_event(:update_attributes => false))
        put :update, :id => "1"
        assigns(:event).should equal(mock_event)
      end

      it "should re-render the 'edit' template" do
        Event.stub!(:find).and_return(mock_event(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "responding to DELETE destroy" do

    it "should destroy the requested event" do
      Event.should_receive(:find).with("37").and_return(mock_event)
      mock_event.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "should redirect to the events list" do
      Event.stub!(:find).and_return(mock_event(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(events_url)
    end

  end

end
