require 'test_helper'

class AnalyticsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    @user = users(:admin)
    sign_in @user
    get analytics_index_url
    assert_response :success
  end
end
