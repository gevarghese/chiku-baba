require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get faq" do
    get pages_faq_url
    assert_response :success
  end

  test "should get terms" do
    get pages_terms_url
    assert_response :success
  end

  test "should get cookies" do
    get pages_cookies_url
    assert_response :success
  end

  test "should get privecy_policy" do
    get pages_privecy_policy_url
    assert_response :success
  end

  test "should get help_center" do
    get pages_help_center_url
    assert_response :success
  end
end
