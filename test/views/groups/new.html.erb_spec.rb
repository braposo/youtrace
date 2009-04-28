require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/groups/new.html.erb" do
  include GroupsHelper
  
  before(:each) do
    assigns[:group] = stub_model(Group,
      :new_record? => true,
      :name => "value for name",
      :description => "value for description",
      :photo => "value for photo",
      :privacy => "1",
      :traced => 
    )
  end

  it "should render new form" do
    render "/groups/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", groups_path) do
      with_tag("input#group_name[name=?]", "group[name]")
      with_tag("input#group_description[name=?]", "group[description]")
      with_tag("input#group_photo[name=?]", "group[photo]")
      with_tag("input#group_privacy[name=?]", "group[privacy]")
      with_tag("input#group_traced[name=?]", "group[traced]")
    end
  end
end


