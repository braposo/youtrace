require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/groups/index.html.erb" do
  include GroupsHelper
  
  before(:each) do
    assigns[:groups] = [
      stub_model(Group,
        :name => "value for name",
        :description => "value for description",
        :photo => "value for photo",
        :privacy => "1",
        :traced => 
      ),
      stub_model(Group,
        :name => "value for name",
        :description => "value for description",
        :photo => "value for photo",
        :privacy => "1",
        :traced => 
      )
    ]
  end

  it "should render list of groups" do
    render "/groups/index.html.erb"
    response.should have_tag("tr>td", "value for name", 2)
    response.should have_tag("tr>td", "value for description", 2)
    response.should have_tag("tr>td", "value for photo", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", , 2)
  end
end

