require "application_system_test_case"

class StaticPagesTest < ApplicationSystemTestCase
  setup do
    @static_page = static_pages(:one)
  end

  test "visiting the index" do
    visit static_pages_url
    assert_selector "h1", text: "Static pages"
  end

  test "should create static page" do
    visit static_pages_url
    click_on "New static page"

    click_on "Create Static page"

    assert_text "Static page was successfully created"
    click_on "Back"
  end

  test "should update Static page" do
    visit static_page_url(@static_page)
    click_on "Edit this static page", match: :first

    click_on "Update Static page"

    assert_text "Static page was successfully updated"
    click_on "Back"
  end

  test "should destroy Static page" do
    visit static_page_url(@static_page)
    click_on "Destroy this static page", match: :first

    assert_text "Static page was successfully destroyed"
  end
end
