require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/traces/index.html.erb" do
  include TracesHelper
  
  before(:each) do
    assigns[:traces] = [
      stub_model(Trace),
      stub_model(Trace)
    ]
  end

  it "should render list of traces" do
    render "/traces/index.html.erb"
  end
end

