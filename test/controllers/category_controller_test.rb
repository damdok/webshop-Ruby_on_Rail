require 'test_helper'

class CategoryControllerTest < ActionController::TestCase
  test "should get category" do
    get :category
    assert_response :success
  end

end
