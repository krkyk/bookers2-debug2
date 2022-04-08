require "test_helper"

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get index_show_url
    assert_response :success
  end

  test "should get create" do
    get index_create_url
    assert_response :success
  end

  test "should get update" do
    get index_update_url
    assert_response :success
  end

  test "should get edit" do
    get index_edit_url
    assert_response :success
  end

  test "should get new" do
    get index_new_url
    assert_response :success
  end
end
