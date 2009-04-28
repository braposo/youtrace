require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Group do
  before(:each) do
    @valid_attributes = {
      :name => "group name",
      :description => "description ",
      :photo => "photourl",
      :privacy => "1",
      :traced => 200.23
    }
  end

  it "should create a new instance given valid attributes" do
    Group.create!(@valid_attributes)
  end
  
  it "should be invalid without a name" do
    @group = Group.new(@valid_attributes.except(:name))
    @group.should_not be_valid
    @group.errors.on(:name).should eql("is required")
    @group.name = "group name"
    @group.should be_valid
  end
  
  it "should be invalid if name is shorter than 4 characters in length" do
    @group = Group.new(@valid_attributes.except(:name))
    @group.name = 'abc'
    @group.should_not be_valid
    @group.name = 'group name'
    @group.should be_valid
  end
end
