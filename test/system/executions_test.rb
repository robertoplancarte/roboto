require "application_system_test_case"

class ExecutionsTest < ApplicationSystemTestCase
  setup do
    @execution = executions(:one)
  end

  test "visiting the index" do
    visit executions_url
    assert_selector "h1", text: "Executions"
  end

  test "creating a Execution" do
    visit executions_url
    click_on "New Execution"

    fill_in "Aasm state", with: @execution.aasm_state
    fill_in "Environment", with: @execution.environment_id
    fill_in "Finished at", with: @execution.finished_at
    fill_in "Input", with: @execution.input
    fill_in "Output", with: @execution.output
    fill_in "Started at", with: @execution.started_at
    fill_in "User", with: @execution.user_id
    click_on "Create Execution"

    assert_text "Execution was successfully created"
    click_on "Back"
  end

  test "updating a Execution" do
    visit executions_url
    click_on "Edit", match: :first

    fill_in "Aasm state", with: @execution.aasm_state
    fill_in "Environment", with: @execution.environment_id
    fill_in "Finished at", with: @execution.finished_at
    fill_in "Input", with: @execution.input
    fill_in "Output", with: @execution.output
    fill_in "Started at", with: @execution.started_at
    fill_in "User", with: @execution.user_id
    click_on "Update Execution"

    assert_text "Execution was successfully updated"
    click_on "Back"
  end

  test "destroying a Execution" do
    visit executions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Execution was successfully destroyed"
  end
end
