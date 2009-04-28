require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/events/edit.html.erb" do
  include EventsHelper
  
  before(:each) do
    assigns[:event] = @event = stub_model(Event,
      :new_record? => false,
      :type => "value for type",
      :text => "value for text",
      :private => false,
    )
  end

  it "should render edit form" do
    render "/events/edit.html.erb"
    
    response.should have_tag("form[action=#{event_path(@event)}][method=post]") do
      with_tag('input#event_type[name=?]', "event[type]")
      with_tag('textarea#event_text[name=?]', "event[text]")
      with_tag('input#event_private[name=?]', "event[private]")
    end
  end
end


