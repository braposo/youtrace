require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vehicle do
  before(:each) do
    @valid_attributes = {
      :kind => "value for kind",
      :make => "value for make",
      :model => "value for model",
      :displace => "value for displace",
      :highway => "9.99",
      :city => "9.99",
      :combined => "9.99"
    }
  end

  it "should create a new instance given valid attributes" do
    Vehicle.create!(@valid_attributes)
  end
end
