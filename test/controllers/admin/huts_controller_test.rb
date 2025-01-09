require "test_helper"

class Admin::HutsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_huts_new_url
    assert_response :success
  end

  test "should get index" do
    get admin_huts_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_huts_create_url
    assert_response :success
  end

  test "should get show" do
    get admin_huts_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_huts_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_huts_update_url
    assert_response :success
  end
end
