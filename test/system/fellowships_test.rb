require "application_system_test_case"

class FellowshipsTest < ApplicationSystemTestCase
  setup do
    @fellowship = fellowships(:one)
  end

  test "visiting the index" do
    visit fellowships_url
    assert_selector "h1", text: "Fellowships"
  end

  test "creating a Fellowship" do
    visit fellowships_url
    click_on "New Fellowship"

    fill_in "Author", with: @fellowship.author_id
    check "Clear name" if @fellowship.clear_name
    fill_in "Community", with: @fellowship.community_id
    fill_in "Created at", with: @fellowship.created_at
    fill_in "Description", with: @fellowship.description
    fill_in "Flags count", with: @fellowship.flags_count
    fill_in "Geozone", with: @fellowship.geozone_id
    fill_in "Id", with: @fellowship.id
    fill_in "Name", with: @fellowship.name
    fill_in "Organization", with: @fellowship.organization_id
    fill_in "Responsible", with: @fellowship.responsible_id
    fill_in "Updated at", with: @fellowship.updated_at
    click_on "Create Fellowship"

    assert_text "Fellowship was successfully created"
    click_on "Back"
  end

  test "updating a Fellowship" do
    visit fellowships_url
    click_on "Edit", match: :first

    fill_in "Author", with: @fellowship.author_id
    check "Clear name" if @fellowship.clear_name
    fill_in "Community", with: @fellowship.community_id
    fill_in "Created at", with: @fellowship.created_at
    fill_in "Description", with: @fellowship.description
    fill_in "Flags count", with: @fellowship.flags_count
    fill_in "Geozone", with: @fellowship.geozone_id
    fill_in "Id", with: @fellowship.id
    fill_in "Name", with: @fellowship.name
    fill_in "Organization", with: @fellowship.organization_id
    fill_in "Responsible", with: @fellowship.responsible_id
    fill_in "Updated at", with: @fellowship.updated_at
    click_on "Update Fellowship"

    assert_text "Fellowship was successfully updated"
    click_on "Back"
  end

  test "destroying a Fellowship" do
    visit fellowships_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fellowship was successfully destroyed"
  end
end
