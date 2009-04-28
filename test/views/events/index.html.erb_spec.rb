require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/index.html.erb" do
  include EventsHelper
  
  before(:each) do
    assigns[:events] = [
      stub_model(Event,
        :type => "value for type",
        :text => "value for text",
        :private => false,
      ),
      stub_model(Event,
        :type => "value for type",
        :text => "value for text",
        :private => false,
      )
    ]
  end

  it "should render list of events" do
    render "/events/index.html.erb"
    response.should have_tag("tr>td", "value for type", 2)
    response.should have_tag("tr>td", "value for text", 2)
    response.should have_tag("tr>td", false, 2)
  end
end

