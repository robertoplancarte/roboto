require "application_system_test_case"

class ScriptsTest < ApplicationSystemTestCase
  setup do
    @script = scripts(:one)
  end

  test "visiting the index" do
    visit scripts_url
    assert_selector "h1", text: "Scripts"
  end

  test "creating a Script" do
    visit scripts_url
    click_on "New Script"

    fill_in "Aasm state", with: @script.aasm_state
    fill_in "Code", with: @script.code
    fill_in "Command", with: @script.command
    fill_in "Path to application", with: @script.path_to_application
    fill_in "Title", with: @script.title
    click_on "Create Script"

    assert_text "Script was successfully created"
    click_on "Back"
  end

  test "updating a Script" do
    visit scripts_url
    click_on "Edit", match: :first

    fill_in "Aasm state", with: @script.aasm_state
    fill_in "Code", with: @script.code
    fill_in "Command", with: @script.command
    fill_in "Path to application", with: @script.path_to_application
    fill_in "Title", with: @script.title
    click_on "Update Script"

    assert_text "Script was successfully updated"
    click_on "Back"
  end

  test "destroying a Script" do
    visit scripts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Script was successfully destroyed"
  end
end
