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

    check "Admin public show address" if @fellowship.admin_public_show_address
    check "Admin public show city" if @fellowship.admin_public_show_city
    check "Admin public show country" if @fellowship.admin_public_show_country
    check "Admin public show date of birth" if @fellowship.admin_public_show_date_of_birth
    check "Admin public show full name" if @fellowship.admin_public_show_full_name
    check "Admin public show gender" if @fellowship.admin_public_show_gender
    check "Admin public show phone number" if @fellowship.admin_public_show_phone_number
    check "Admin public show state" if @fellowship.admin_public_show_state
    check "Admin required address" if @fellowship.admin_required_address
    check "Admin required city" if @fellowship.admin_required_city
    check "Admin required country" if @fellowship.admin_required_country
    check "Admin required date of birth" if @fellowship.admin_required_date_of_birth
    check "Admin required full name" if @fellowship.admin_required_full_name
    check "Admin required gender" if @fellowship.admin_required_gender
    check "Admin required phone number" if @fellowship.admin_required_phone_number
    check "Admin required state" if @fellowship.admin_required_state
    fill_in "Author", with: @fellowship.author_id
    check "Clear name" if @fellowship.clear_name
    fill_in "Community", with: @fellowship.community_id
    fill_in "Created at", with: @fellowship.created_at
    fill_in "Description", with: @fellowship.description
    fill_in "Email", with: @fellowship.email
    fill_in "Flags count", with: @fellowship.flags_count
    fill_in "Geozone", with: @fellowship.geozone_id
    fill_in "Name", with: @fellowship.name
    fill_in "Organization", with: @fellowship.organization_id
    fill_in "Responsible", with: @fellowship.responsible_id
    fill_in "Updatet at", with: @fellowship.updatet_at
    fill_in "User", with: @fellowship.user_id
    check "User public show address" if @fellowship.user_public_show_address
    check "User public show city" if @fellowship.user_public_show_city
    check "User public show country" if @fellowship.user_public_show_country
    check "User public show date of birth" if @fellowship.user_public_show_date_of_birth
    check "User public show full name" if @fellowship.user_public_show_full_name
    check "User public show gender" if @fellowship.user_public_show_gender
    check "User public show phone number" if @fellowship.user_public_show_phone_number
    check "User public show state" if @fellowship.user_public_show_state
    check "User required adress" if @fellowship.user_required_adress
    check "User required city" if @fellowship.user_required_city
    check "User required country" if @fellowship.user_required_country
    check "User required date of birth" if @fellowship.user_required_date_of_birth
    check "User required full name" if @fellowship.user_required_full_name
    check "User required gender" if @fellowship.user_required_gender
    check "User required phone number" if @fellowship.user_required_phone_number
    check "User required state" if @fellowship.user_required_state
    click_on "Create Fellowship"

    assert_text "Fellowship was successfully created"
    click_on "Back"
  end

  test "updating a Fellowship" do
    visit fellowships_url
    click_on "Edit", match: :first

    check "Admin public show address" if @fellowship.admin_public_show_address
    check "Admin public show city" if @fellowship.admin_public_show_city
    check "Admin public show country" if @fellowship.admin_public_show_country
    check "Admin public show date of birth" if @fellowship.admin_public_show_date_of_birth
    check "Admin public show full name" if @fellowship.admin_public_show_full_name
    check "Admin public show gender" if @fellowship.admin_public_show_gender
    check "Admin public show phone number" if @fellowship.admin_public_show_phone_number
    check "Admin public show state" if @fellowship.admin_public_show_state
    check "Admin required address" if @fellowship.admin_required_address
    check "Admin required city" if @fellowship.admin_required_city
    check "Admin required country" if @fellowship.admin_required_country
    check "Admin required date of birth" if @fellowship.admin_required_date_of_birth
    check "Admin required full name" if @fellowship.admin_required_full_name
    check "Admin required gender" if @fellowship.admin_required_gender
    check "Admin required phone number" if @fellowship.admin_required_phone_number
    check "Admin required state" if @fellowship.admin_required_state
    fill_in "Author", with: @fellowship.author_id
    check "Clear name" if @fellowship.clear_name
    fill_in "Community", with: @fellowship.community_id
    fill_in "Created at", with: @fellowship.created_at
    fill_in "Description", with: @fellowship.description
    fill_in "Email", with: @fellowship.email
    fill_in "Flags count", with: @fellowship.flags_count
    fill_in "Geozone", with: @fellowship.geozone_id
    fill_in "Name", with: @fellowship.name
    fill_in "Organization", with: @fellowship.organization_id
    fill_in "Responsible", with: @fellowship.responsible_id
    fill_in "Updatet at", with: @fellowship.updatet_at
    fill_in "User", with: @fellowship.user_id
    check "User public show address" if @fellowship.user_public_show_address
    check "User public show city" if @fellowship.user_public_show_city
    check "User public show country" if @fellowship.user_public_show_country
    check "User public show date of birth" if @fellowship.user_public_show_date_of_birth
    check "User public show full name" if @fellowship.user_public_show_full_name
    check "User public show gender" if @fellowship.user_public_show_gender
    check "User public show phone number" if @fellowship.user_public_show_phone_number
    check "User public show state" if @fellowship.user_public_show_state
    check "User required adress" if @fellowship.user_required_adress
    check "User required city" if @fellowship.user_required_city
    check "User required country" if @fellowship.user_required_country
    check "User required date of birth" if @fellowship.user_required_date_of_birth
    check "User required full name" if @fellowship.user_required_full_name
    check "User required gender" if @fellowship.user_required_gender
    check "User required phone number" if @fellowship.user_required_phone_number
    check "User required state" if @fellowship.user_required_state
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
