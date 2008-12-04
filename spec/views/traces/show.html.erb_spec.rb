require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/traces/show.html.erb" do
  include TracesHelper
  
  before(:each) do
    assigns[:trace] = @trace = stub_model(Trace)
  end

  it "should render attributes in <p>" do
    render "/traces/show.html.erb"
  end
end

