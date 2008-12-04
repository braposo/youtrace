require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/traces/new.html.erb" do
  include TracesHelper
  
  before(:each) do
    assigns[:trace] = stub_model(Trace,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/traces/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", traces_path) do
    end
  end
end


