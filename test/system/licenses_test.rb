require "application_system_test_case"

class LicensesTest < ApplicationSystemTestCase
  setup do
    @license = licenses(:one)
  end

  test "visiting the index" do
    visit licenses_url
    assert_selector "h1", text: "Licenses"
  end

  test "creating a License" do
    visit licenses_url
    click_on "New License"

    fill_in "Title", with: @license.title
    click_on "Create License"

    assert_text "License was successfully created"
    click_on "Back"
  end

  test "updating a License" do
    visit licenses_url
    click_on "Edit", match: :first

    fill_in "Title", with: @license.title
    click_on "Update License"

    assert_text "License was successfully updated"
    click_on "Back"
  end

  test "destroying a License" do
    visit licenses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "License was successfully destroyed"
  end
end
