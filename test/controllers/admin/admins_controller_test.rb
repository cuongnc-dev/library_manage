require 'test_helper'

class Admin::AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get admin_home" do
    get admin_admins_admin_home_url
    assert_response :success
  end

end
