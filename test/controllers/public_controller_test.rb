require "test_helper"

class PublicControllerTest < ActionDispatch::IntegrationTest
  test "should get logs" do
    get public_logs_url
    assert_response :success
  end
end
