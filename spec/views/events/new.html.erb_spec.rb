require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/new.html.erb" do
  include EventsHelper
  
  before(:each) do
    assigns[:event] = stub_model(Event,
      :new_record? => true,
      :type => "value for type",
      :text => "value for text",
      :private => false,
    )
  end

  it "should render new form" do
    render "/events/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", events_path) do
      with_tag("input#event_type[name=?]", "event[type]")
      with_tag("textarea#event_text[name=?]", "event[text]")
      with_tag("input#event_private[name=?]", "event[private]")
    end
  end
end


