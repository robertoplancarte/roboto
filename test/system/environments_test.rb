require "application_system_test_case"

class EnvironmentsTest < ApplicationSystemTestCase
  setup do
    @environment = environments(:one)
  end

  test "visiting the index" do
    visit environments_url
    assert_selector "h1", text: "Environments"
  end

  test "creating a Environment" do
    visit environments_url
    click_on "New Environment"

    fill_in "Fqdn", with: @environment.fqdn
    fill_in "Name", with: @environment.name
    fill_in "Private key path", with: @environment.private_key_path
    fill_in "User name", with: @environment.user_name
    click_on "Create Environment"

    assert_text "Environment was successfully created"
    click_on "Back"
  end

  test "updating a Environment" do
    visit environments_url
    click_on "Edit", match: :first

    fill_in "Fqdn", with: @environment.fqdn
    fill_in "Name", with: @environment.name
    fill_in "Private key path", with: @environment.private_key_path
    fill_in "User name", with: @environment.user_name
    click_on "Update Environment"

    assert_text "Environment was successfully updated"
    click_on "Back"
  end

  test "destroying a Environment" do
    visit environments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Environment was successfully destroyed"
  end
end
