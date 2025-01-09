require "test_helper"

class Public::HutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_huts_index_url
    assert_response :success
  end

  test "should get show" do
    get public_huts_show_url
    assert_response :success
  end
end
