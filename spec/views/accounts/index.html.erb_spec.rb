require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/index.html.erb" do
  include AccountsHelper
  
  before(:each) do
    assigns[:accounts] = [
      stub_model(Account,
        :username => "value for username",
        :password => "value for password",
        :email => "value for email",
        :status => "1",
        :code => "value for code"
      ),
      stub_model(Account,
        :username => "value for username",
        :password => "value for password",
        :email => "value for email",
        :status => "1",
        :code => "value for code"
      )
    ]
  end

  it "should render list of accounts" do
    render "/accounts/index.html.erb"
    response.should have_tag("tr>td", "value for username", 2)
    response.should have_tag("tr>td", "value for password", 2)
    response.should have_tag("tr>td", "value for email", 2)
    response.should have_tag("tr>td", "1", 2)
    response.should have_tag("tr>td", "value for code", 2)
  end
end

