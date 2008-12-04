require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  before(:each) do
    @valid_attributes = {
      :username => "username",
      :password => "password",
      :email => "test@doyoutrace.com",
      :status => "0",
      :code => "value for code"
    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end
  
  it "should be invalid without a username" do
    @account = Account.new(@valid_attributes.except(:username))
    @account.should_not be_valid
    @account.errors.on(:username).should eql("is required") 
    @account.username = 'someusername'
    @account.should be_valid
  end
  
  it "should be invalid without an email" do
    @account = Account.new(@valid_attributes.except(:email))
    @account.should_not be_valid
    @account.errors.on(:email).should eql("is required")
    @account.email = 'teste@youtrace.com'
    @account.should be_valid
  end
  
  it "should be invalid without a password" do
    @account = Account.new(@valid_attributes.except(:password))
    @account.should_not be_valid
    @account.errors.on(:password).should eql("is required")
    @account.password = 'pwdtest'
    @account.should be_valid
  end
  
  it "should be invalid if password is not between 6 and 12 characters in length" do
    @account = Account.new(@valid_attributes.except(:password))
    @account.password = 'reallylongpassword'
    @account.should_not be_valid
    @account.password = 'pwd'
    @account.should_not be_valid
    @account.password = 'password'
    @account.should be_valid
  end
  
  it "should be invalid if status is 1" do
    @account = Account.new(@valid_attributes.except(:status))
    if @account.status == 1
      @account.should be_valid
    else
      @account.should_not be_valid
    end
  end
end
