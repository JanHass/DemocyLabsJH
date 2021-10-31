require "rails_helper"

describe "Commenting proposals" do
  let(:user) { create :user }
  let(:proposal) { create :proposal }

  it_behaves_like "flaggable", :proposal_comment

  scenario "Index" do
    3.times { create(:comment, commentable: proposal) }
    comment = Comment.includes(:user).last

    visit proposal_path(proposal)

    expect(page).to have_css(".comment", count: 3)

    within first(".comment") do
      expect(page).to have_content comment.user.name
      expect(page).to have_content I18n.l(comment.created_at, format: :datetime)
      expect(page).to have_content comment.body
    end
  end

  scenario "Show" do
    parent_comment = create(:comment, commentable: proposal, body: "Parent")
    create(:comment, commentable: proposal, parent: parent_comment, body: "First subcomment")
    create(:comment, commentable: proposal, parent: parent_comment, body: "Last subcomment")

    visit comment_path(parent_comment)

    expect(page).to have_css(".comment", count: 3)
    expect(page).to have_content "Parent"
    expect(page).to have_content "First subcomment"
    expect(page).to have_content "Last subcomment"
    expect(page).to have_link "Go back to #{proposal.title}", href: proposal_path(proposal)

    within ".comment", text: "Parent" do
      expect(page).to have_selector(".comment", count: 2)
    end
  end

  scenario "Link to comment show" do
    comment = create(:comment, commentable: proposal, user: user)

    visit proposal_path(proposal)

    within "#comment_#{comment.id}" do
      expect(page).to have_link comment.created_at.strftime("%Y-%m-%d %T")
    end

    click_link comment.created_at.strftime("%Y-%m-%d %T")

    expect(page).to have_link "Go back to #{proposal.title}"
    expect(page).to have_current_path(comment_path(comment))
  end

  scenario "Collapsable comments" do
    parent_comment = create(:comment, body: "Main comment", commentable: proposal)
    child_comment  = create(:comment, body: "First subcomment", commentable: proposal, parent: parent_comment)
    grandchild_comment = create(:comment, body: "Last subcomment", commentable: proposal, parent: child_comment)

    visit proposal_path(proposal)

    expect(page).to have_css(".comment", count: 3)
    expect(page).to have_content("1 response (collapse)", count: 2)

    within ".comment .comment", text: "First subcomment" do
      click_link text: "1 response (collapse)"
    end

    expect(page).to have_css(".comment", count: 2)
    expect(page).to have_content("1 response (collapse)")
    expect(page).to have_content("1 response (show)")
    expect(page).not_to have_content grandchild_comment.body

    within ".comment .comment", text: "First subcomment" do
      click_link text: "1 response (show)"
    end

    expect(page).to have_css(".comment", count: 3)
    expect(page).to have_content("1 response (collapse)", count: 2)
    expect(page).to have_content grandchild_comment.body

    within ".comment", text: "Main comment" do
      click_link text: "1 response (collapse)", match: :first
    end

    expect(page).to have_css(".comment", count: 1)
    expect(page).to have_content("1 response (show)")
    expect(page).not_to have_content child_comment.body
    expect(page).not_to have_content grandchild_comment.body
  end

  scenario "Comment order" do
    c1 = create(:comment, :with_confidence_score, commentable: proposal, cached_votes_up: 100,
                                                  cached_votes_total: 120, created_at: Time.current - 2)
    c2 = create(:comment, :with_confidence_score, commentable: proposal, cached_votes_up: 10,
                                                  cached_votes_total: 12, created_at: Time.current - 1)
    c3 = create(:comment, :with_confidence_score, commentable: proposal, cached_votes_up: 1,
                                                  cached_votes_total: 2, created_at: Time.current)

    visit proposal_path(proposal, order: :most_voted)

    expect(c1.body).to appear_before(c2.body)
    expect(c2.body).to appear_before(c3.body)

    click_link "Newest first"

    expect(page).to have_link "Newest first", class: "is-active"
    expect(page).to have_current_path(/#comments/, url: true)
    expect(c3.body).to appear_before(c2.body)
    expect(c2.body).to appear_before(c1.body)

    click_link "Oldest first"

    expect(page).to have_link "Oldest first", class: "is-active"
    expect(page).to have_current_path(/#comments/, url: true)
    expect(c1.body).to appear_before(c2.body)
    expect(c2.body).to appear_before(c3.body)
  end

  scenario "Creation date works differently in roots and in child comments, when sorting by confidence_score" do
    old_root = create(:comment, commentable: proposal, created_at: Time.current - 10)
    new_root = create(:comment, commentable: proposal, created_at: Time.current)
    old_child = create(:comment, commentable: proposal, parent_id: new_root.id, created_at: Time.current - 10)
    new_child = create(:comment, commentable: proposal, parent_id: new_root.id, created_at: Time.current)

    visit proposal_path(proposal, order: :most_voted)

    expect(new_root.body).to appear_before(old_root.body)
    expect(old_child.body).to appear_before(new_child.body)

    visit proposal_path(proposal, order: :newest)

    expect(new_root.body).to appear_before(old_root.body)
    expect(new_child.body).to appear_before(old_child.body)

    visit proposal_path(proposal, order: :oldest)

    expect(old_root.body).to appear_before(new_root.body)
    expect(old_child.body).to appear_before(new_child.body)
  end

  scenario "Turns links into html links" do
    create :comment, commentable: proposal, body: "Built with http://rubyonrails.org/"

    visit proposal_path(proposal)

    within first(".comment") do
      expect(page).to have_content "Built with http://rubyonrails.org/"
      expect(page).to have_link("http://rubyonrails.org/", href: "http://rubyonrails.org/")
      expect(find_link("http://rubyonrails.org/")[:rel]).to eq("nofollow")
      expect(find_link("http://rubyonrails.org/")[:target]).to eq("_blank")
    end
  end

  scenario "Sanitizes comment body for security" do
    create :comment, commentable: proposal,
                     body: "<script>alert('hola')</script> <a href=\"javascript:alert('sorpresa!')\">click me<a/> http://www.url.com"

    visit proposal_path(proposal)

    within first(".comment") do
      expect(page).to have_content "click me http://www.url.com"
      expect(page).to have_link("http://www.url.com", href: "http://www.url.com")
      expect(page).not_to have_link("click me")
    end
  end

  scenario "Paginated comments" do
    per_page = 10
    (per_page + 2).times { create(:comment, commentable: proposal) }

    visit proposal_path(proposal)

    expect(page).to have_css(".comment", count: per_page)
    within("ul.pagination") do
      expect(page).to have_content("1")
      expect(page).to have_content("2")
      expect(page).not_to have_content("3")
      click_link "Next", exact: false
    end

    expect(page).to have_css(".comment", count: 2)
    expect(page).to have_current_path(/#comments/, url: true)
  end

  describe "Not logged user" do
    scenario "can not see comments forms" do
      create(:comment, commentable: proposal)
      visit proposal_path(proposal)

      expect(page).to have_content "You must sign in or sign up to leave a comment"
      within("#comments") do
        expect(page).not_to have_content "Write a comment"
        expect(page).not_to have_content "Reply"
      end
    end
  end

  scenario "Create" do
    login_as(user)
    visit proposal_path(proposal)

    fill_in "Leave your comment", with: "Have you thought about...?"
    click_button "Publish comment"

    within "#comments" do
      expect(page).to have_content "Have you thought about...?"
    end

    within "#tab-comments-label" do
      expect(page).to have_content "Comments (1)"
    end
  end

  scenario "Errors on create" do
    login_as(user)
    visit proposal_path(proposal)

    click_button "Publish comment"

    expect(page).to have_content "Can't be blank"
  end

  scenario "Reply" do
    citizen = create(:user, username: "Ana")
    manuela = create(:user, username: "Manuela")
    comment = create(:comment, commentable: proposal, user: citizen)

    login_as(manuela)
    visit proposal_path(proposal)

    click_link "Reply"

    within "#js-comment-form-comment_#{comment.id}" do
      fill_in "Leave your comment", with: "It will be done next week."
      click_button "Publish reply"
    end

    within "#comment_#{comment.id}" do
      expect(page).to have_content "It will be done next week."
    end

    expect(page).not_to have_selector("#js-comment-form-comment_#{comment.id}")
  end

  scenario "Reply update parent comment responses count" do
    comment = create(:comment, commentable: proposal)

    login_as(create(:user))
    visit proposal_path(proposal)

    within ".comment", text: comment.body do
      click_link "Reply"
      fill_in "Leave your comment", with: "It will be done next week."
      click_button "Publish reply"

      expect(page).to have_content("1 response (collapse)")
    end
  end

  scenario "Reply show parent comments responses when hidden" do
    comment = create(:comment, commentable: proposal)
    create(:comment, commentable: proposal, parent: comment)

    login_as(create(:user))
    visit proposal_path(proposal)

    within ".comment", text: comment.body do
      click_link text: "1 response (collapse)"
      click_link "Reply"
      fill_in "Leave your comment", with: "It will be done next week."
      click_button "Publish reply"

      expect(page).to have_content("It will be done next week.")
    end
  end

  scenario "Errors on reply" do
    comment = create(:comment, commentable: proposal, user: user)

    login_as(user)
    visit proposal_path(proposal)

    click_link "Reply"

    within "#js-comment-form-comment_#{comment.id}" do
      click_button "Publish reply"
      expect(page).to have_content "Can't be blank"
    end
  end

  scenario "N replies" do
    parent = create(:comment, commentable: proposal)

    7.times do
      create(:comment, commentable: proposal, parent: parent)
      parent = parent.children.first
    end

    visit proposal_path(proposal)
    expect(page).to have_css(".comment.comment.comment.comment.comment.comment.comment.comment")
  end

  scenario "Erasing a comment's author" do
    proposal = create(:proposal)
    comment = create(:comment, commentable: proposal, body: "this should be visible")
    comment.user.erase

    visit proposal_path(proposal)
    within "#comment_#{comment.id}" do
      expect(page).to have_content("User deleted")
      expect(page).to have_content("this should be visible")
    end
  end

  describe "Moderators" do
    scenario "can create comment as a moderator" do
      moderator = create(:moderator)

      login_as(moderator.user)
      visit proposal_path(proposal)

      fill_in "Leave your comment", with: "I am moderating!"
      check "comment-as-moderator-proposal_#{proposal.id}"
      click_button "Publish comment"

      within "#comments" do
        expect(page).to have_content "I am moderating!"
        expect(page).to have_content "Moderator ##{moderator.id}"
        expect(page).to have_css "div.is-moderator"
        expect(page).to have_css "img.moderator-avatar"
      end
    end

    scenario "can create reply as a moderator" do
      citizen = create(:user, username: "Ana")
      manuela = create(:user, username: "Manuela")
      moderator = create(:moderator, user: manuela)
      comment = create(:comment, commentable: proposal, user: citizen)

      login_as(manuela)
      visit proposal_path(proposal)

      click_link "Reply"

      within "#js-comment-form-comment_#{comment.id}" do
        fill_in "Leave your comment", with: "I am moderating!"
        check "comment-as-moderator-comment_#{comment.id}"
        click_button "Publish reply"
      end

      within "#comment_#{comment.id}" do
        expect(page).to have_content "I am moderating!"
        expect(page).to have_content "Moderator ##{moderator.id}"
        expect(page).to have_css "div.is-moderator"
        expect(page).to have_css "img.moderator-avatar"
      end

      expect(page).not_to have_selector("#js-comment-form-comment_#{comment.id}")
    end

    scenario "can not comment as an administrator" do
      moderator = create(:moderator)

      login_as(moderator.user)
      visit proposal_path(proposal)

      expect(page).not_to have_content "Comment as administrator"
    end
  end

  describe "Administrators" do
    scenario "can create comment as an administrator" do
      admin = create(:administrator)

      login_as(admin.user)
      visit proposal_path(proposal)

      fill_in "Leave your comment", with: "I am your Admin!"
      check "comment-as-administrator-proposal_#{proposal.id}"
      click_button "Publish comment"

      within "#comments" do
        expect(page).to have_content "I am your Admin!"
        expect(page).to have_content "Administrator ##{admin.id}"
        expect(page).to have_css "div.is-admin"
        expect(page).to have_css "img.admin-avatar"
      end
    end

    scenario "can create reply as an administrator" do
      citizen = create(:user, username: "Ana")
      manuela = create(:user, username: "Manuela")
      admin   = create(:administrator, user: manuela)
      comment = create(:comment, commentable: proposal, user: citizen)

      login_as(manuela)
      visit proposal_path(proposal)

      click_link "Reply"

      within "#js-comment-form-comment_#{comment.id}" do
        fill_in "Leave your comment", with: "Top of the world!"
        check "comment-as-administrator-comment_#{comment.id}"
        click_button "Publish reply"
      end

      within "#comment_#{comment.id}" do
        expect(page).to have_content "Top of the world!"
        expect(page).to have_content "Administrator ##{admin.id}"
        expect(page).to have_css "div.is-admin"
        expect(page).to have_css "img.admin-avatar"
      end

      expect(page).not_to have_selector("#js-comment-form-comment_#{comment.id}")
    end

    scenario "can not comment as a moderator", :admin do
      visit proposal_path(proposal)

      expect(page).not_to have_content "Comment as moderator"
    end
  end

  describe "Voting comments" do
    let(:verified)   { create(:user, verified_at: Time.current) }
    let(:unverified) { create(:user) }
    let(:proposal)   { create(:proposal) }
    let!(:comment)   { create(:comment, commentable: proposal) }

    before do
      login_as(verified)
    end

    scenario "Show" do
      create(:vote, voter: verified, votable: comment, vote_flag: true)
      create(:vote, voter: unverified, votable: comment, vote_flag: false)

      visit proposal_path(proposal)

      within("#comment_#{comment.id}_votes") do
        within(".in_favor") do
          expect(page).to have_content "1"
        end

        within(".against") do
          expect(page).to have_content "1"
        end

        expect(page).to have_content "2 votes"
      end
    end

    scenario "Create" do
      visit proposal_path(proposal)

      within("#comment_#{comment.id}_votes") do
        find(".in_favor a").click

        within(".in_favor") do
          expect(page).to have_content "1"
        end

        within(".against") do
          expect(page).to have_content "0"
        end

        expect(page).to have_content "1 vote"
      end
    end

    scenario "Update" do
      visit proposal_path(proposal)

      within("#comment_#{comment.id}_votes") do
        find(".in_favor a").click

        within(".in_favor") do
          expect(page).to have_content "1"
        end

        find(".against a").click

        within(".in_favor") do
          expect(page).to have_content "0"
        end

        within(".against") do
          expect(page).to have_content "1"
        end

        expect(page).to have_content "1 vote"
      end
    end

    scenario "Trying to vote multiple times" do
      visit proposal_path(proposal)

      within("#comment_#{comment.id}_votes") do
        find(".in_favor a").click

        within(".in_favor") do
          expect(page).to have_content "1"
        end

        find(".in_favor a").click

        within(".in_favor") do
          expect(page).to have_content "1"
        end

        within(".against") do
          expect(page).to have_content "0"
        end

        expect(page).to have_content "1 vote"
      end
    end
  end
end
