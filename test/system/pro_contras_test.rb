require "application_system_test_case"

class ProContrasTest < ApplicationSystemTestCase
  setup do
    @pro_contra = pro_contras(:one)
  end

  test "visiting the index" do
    visit pro_contras_url
    assert_selector "h1", text: "Pro Contras"
  end

  test "creating a Pro contra" do
    visit pro_contras_url
    click_on "New Pro Contra"

    fill_in "Body", with: @pro_contra.body
    fill_in "Debate", with: @pro_contra.debate_id
    fill_in "Dislikes", with: @pro_contra.dislikes
    fill_in "Email", with: @pro_contra.email
    fill_in "Fellowship", with: @pro_contra.fellowship_id
    fill_in "Likes", with: @pro_contra.likes
    fill_in "Move", with: @pro_contra.move
    fill_in "Pc", with: @pro_contra.pc
    fill_in "Poll", with: @pro_contra.poll_id
    fill_in "Proposal", with: @pro_contra.proposal_id
    fill_in "Rating", with: @pro_contra.rating
    fill_in "Reported", with: @pro_contra.reported
    fill_in "Sources", with: @pro_contra.sources
    fill_in "Tag", with: @pro_contra.tag
    fill_in "User", with: @pro_contra.user_id
    fill_in "Vote", with: @pro_contra.vote_id
    click_on "Create Pro contra"

    assert_text "Pro contra was successfully created"
    click_on "Back"
  end

  test "updating a Pro contra" do
    visit pro_contras_url
    click_on "Edit", match: :first

    fill_in "Body", with: @pro_contra.body
    fill_in "Debate", with: @pro_contra.debate_id
    fill_in "Dislikes", with: @pro_contra.dislikes
    fill_in "Email", with: @pro_contra.email
    fill_in "Fellowship", with: @pro_contra.fellowship_id
    fill_in "Likes", with: @pro_contra.likes
    fill_in "Move", with: @pro_contra.move
    fill_in "Pc", with: @pro_contra.pc
    fill_in "Poll", with: @pro_contra.poll_id
    fill_in "Proposal", with: @pro_contra.proposal_id
    fill_in "Rating", with: @pro_contra.rating
    fill_in "Reported", with: @pro_contra.reported
    fill_in "Sources", with: @pro_contra.sources
    fill_in "Tag", with: @pro_contra.tag
    fill_in "User", with: @pro_contra.user_id
    fill_in "Vote", with: @pro_contra.vote_id
    click_on "Update Pro contra"

    assert_text "Pro contra was successfully updated"
    click_on "Back"
  end

  test "destroying a Pro contra" do
    visit pro_contras_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pro contra was successfully destroyed"
  end
end
