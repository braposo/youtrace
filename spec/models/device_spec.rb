require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Device do
  before(:each) do
    @valid_attributes = {
      :brand => "value for brand",
      :model => "value for model",
      :kind => "value for kind"
    }
  end

  it "should create a new instance given valid attributes" do
    Device.create!(@valid_attributes)
  end
end
