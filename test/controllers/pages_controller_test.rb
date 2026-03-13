require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get education" do
    get pages_education_url
    assert_response :success
  end

  test "should get culture" do
    get pages_culture_url
    assert_response :success
  end

  test "should get shop" do
    get pages_shop_url
    assert_response :success
  end

  test "should get cafe" do
    get pages_cafe_url
    assert_response :success
  end
end
