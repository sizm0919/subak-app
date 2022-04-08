require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
    get admins_path
    assert_response :success
  end

  test "should get about" do
    get about_admins_path
    assert_response :success
  end 
end
