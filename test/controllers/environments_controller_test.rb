require 'test_helper'

class EnvironmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @environment = environments(:one)
    @user        = users(:admin)
    sign_in @user
  end

  test "should get index" do
    get environments_url
    assert_response :success
  end

  test "should get new" do
    get new_environment_url
    assert_response :success
  end

  test "should create environment" do
    assert_difference('Environment.count') do
      post environments_url, params: { environment: { fqdn: @environment.fqdn, name: @environment.name, private_key_path: @environment.private_key_path, user_name: @environment.user_name } }
    end

    assert_redirected_to environment_url(Environment.last)
  end

  test "should show environment" do
    get environment_url(@environment)
    assert_response :success
  end

  test "should get edit" do
    get edit_environment_url(@environment)
    assert_response :success
  end

  test "should update environment" do
    patch environment_url(@environment), params: { environment: { fqdn: @environment.fqdn, name: @environment.name, private_key_path: @environment.private_key_path, user_name: @environment.user_name } }
    assert_redirected_to environment_url(@environment)
  end

  test "should destroy environment" do
    assert_difference('Environment.count', -1) do
      delete environment_url(@environment)
    end

    assert_redirected_to environments_url
  end
end
