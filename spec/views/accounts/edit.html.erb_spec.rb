require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/accounts/edit.html.erb" do
  include AccountsHelper
  
  before(:each) do
    assigns[:account] = @account = stub_model(Account,
      :new_record? => false,
      :username => "value for username",
      :password => "value for password",
      :email => "value for email",
      :status => "1",
      :code => "value for code"
    )
  end

  it "should render edit form" do
    render "/accounts/edit.html.erb"
    
    response.should have_tag("form[action=#{account_path(@account)}][method=post]") do
      with_tag('input#account_username[name=?]', "account[username]")
      with_tag('input#account_password[name=?]', "account[password]")
      with_tag('input#account_email[name=?]', "account[email]")
      with_tag('input#account_status[name=?]', "account[status]")
      with_tag('input#account_code[name=?]', "account[code]")
    end
  end
end


