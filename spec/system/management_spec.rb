require "rails_helper"

describe "Management" do
  let(:user) { create(:user) }

  scenario "Should show admin menu if logged user is admin" do
    create(:administrator, user: user)
    login_as(user)

    visit root_path
    click_link "Menu"
    click_link "Management"

    expect(page).to have_content("My content")
    expect(page).to have_content("My account")
    expect(page).to have_content("Sign out")
  end

  scenario "Should not show admin menu if logged user is manager" do
    create(:manager, user: user)
    login_as(user)
    visit root_path

    click_link "Menu"
    click_link "Management"

    expect(page).not_to have_content("My content")
    expect(page).not_to have_content("My account")
    expect(page).not_to have_content("Sign out")
  end
end
