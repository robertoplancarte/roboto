require 'test_helper'

class ScriptsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @script = scripts(:one)
    @user   = users(:admin)
    sign_in @user
  end

  test 'should get index' do
    get scripts_url
    assert_response :success
  end

  test 'should get new' do
    get new_script_url
    assert_response :success
  end

  test 'should create script' do
    assert_difference('Script.count') do
      post scripts_url, params: { script: { aasm_state: @script.aasm_state, code: @script.code, command: @script.command, path_to_application: @script.path_to_application, title: @script.title } }
    end

    assert_redirected_to script_url(Script.last)
  end

  test 'should show script' do
    get script_url(@script)
    assert_response :success
  end

  test 'should get edit' do
    get edit_script_url(@script)
    assert_response :success
  end

  test 'should update script' do
    patch script_url(@script), params: { script: { aasm_state: @script.aasm_state, code: @script.code, command: @script.command, path_to_application: @script.path_to_application, title: @script.title } }
    assert_redirected_to script_url(@script)
  end

  test 'should destroy script' do
    assert_difference('Script.count', -1) do
      delete script_url(@script)
    end

    assert_redirected_to scripts_url
  end
end
