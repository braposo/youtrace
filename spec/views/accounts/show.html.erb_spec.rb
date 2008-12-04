require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/show.html.erb" do
  include AccountsHelper
  
  before(:each) do
    assigns[:account] = @account = stub_model(Account,
      :username => "value for username",
      :password => "value for password",
      :email => "value for email",
      :status => "1",
      :code => "value for code"
    )
  end

  it "should render attributes in <p>" do
    render "/accounts/show.html.erb"
    response.should have_text(/value\ for\ username/)
    response.should have_text(/value\ for\ password/)
    response.should have_text(/value\ for\ email/)
    response.should have_text(/1/)
    response.should have_text(/value\ for\ code/)
  end
end

