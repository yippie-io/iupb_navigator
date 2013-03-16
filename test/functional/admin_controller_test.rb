require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get crawl" do
    get :crawl
    assert_response :success
  end

end
