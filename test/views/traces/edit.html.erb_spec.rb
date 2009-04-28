require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/traces/edit.html.erb" do
  include TracesHelper
  
  before(:each) do
    assigns[:trace] = @trace = stub_model(Trace,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/traces/edit.html.erb"
    
    response.should have_tag("form[action=#{trace_path(@trace)}][method=post]") do
    end
  end
end


