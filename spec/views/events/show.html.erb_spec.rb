require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/show.html.erb" do
  include EventsHelper
  
  before(:each) do
    assigns[:event] = @event = stub_model(Event,
      :type => "value for type",
      :text => "value for text",
      :private => false,
    )
  end

  it "should render attributes in <p>" do
    render "/events/show.html.erb"
    response.should have_text(/value\ for\ type/)
    response.should have_text(/value\ for\ text/)
    response.should have_text(/als/)
  end
end

