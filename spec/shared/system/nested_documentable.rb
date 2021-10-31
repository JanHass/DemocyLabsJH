shared_examples "nested documentable" do |login_as_name, documentable_factory_name, path,
                                          documentable_path_arguments, fill_resource_method_name,
                                          submit_button, documentable_success_notice, management: false|
  let!(:administrator)          { create(:user) }
  let!(:user)                   { create(:user, :level_two) }
  let!(:arguments)              { {} }
  if documentable_factory_name == "dashboard_action"
    let!(:documentable)           { create(documentable_factory_name) }
  else
    let!(:documentable)           { create(documentable_factory_name, author: user) }
  end
  let!(:user_to_login) { send(login_as_name) }
  let(:management) { management }

  before do
    create(:administrator, user: administrator)

    documentable_path_arguments&.each do |argument_name, path_to_value|
      arguments.merge!("#{argument_name}": documentable.send(path_to_value))
    end
  end

  describe "at #{path}" do
    scenario "Should show new document link when max documents allowed limit is not reached" do
      do_login_for user_to_login
      visit send(path, arguments)

      expect(page).to have_css "#new_document_link"
    end

    scenario "Should not show new document link when
              documentable max documents allowed limit is reached" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable.class.max_documents_allowed.times.each do
        click_link "Add new document"
      end

      expect(page).not_to have_css "#new_document_link"
    end

    scenario "Should not show max documents warning when no documents added" do
      do_login_for user_to_login
      visit send(path, arguments)

      expect(page).not_to have_css ".max-documents-notice"
    end

    scenario "Should show max documents warning when max documents allowed limit is reached" do
      do_login_for user_to_login
      visit send(path, arguments)
      documentable.class.max_documents_allowed.times.each do
        documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))
      end

      expect(page).to have_css ".max-documents-notice"
      expect(page).to have_content "Remove document"
    end

    scenario "Should hide max documents warning after any document removal" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable.class.max_documents_allowed.times.each do
        click_link "Add new document"
      end

      all("a", text: "Cancel").last.click

      expect(page).not_to have_css ".max-documents-notice"
    end

    scenario "Should update nested document file name after choosing a file" do
      do_login_for user_to_login
      visit send(path, arguments)

      click_link "Add new document"
      within "#nested-documents" do
        attach_file "Choose document", Rails.root.join("spec/fixtures/files/empty.pdf")

        expect(page).to have_css ".loading-bar.complete"
      end

      expect(page).to have_css ".file-name", text: "empty.pdf"
    end

    scenario "Should update nested document file title with
              file name after choosing a file when no title defined" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))

      expect_document_has_title(0, "empty.pdf")
    end

    scenario "Should not update nested document file title with
              file name after choosing a file when title already defined" do
      do_login_for user_to_login
      visit send(path, arguments)

      click_link "Add new document"
      within "#nested-documents" do
        input = find("input[name$='[title]']")
        fill_in input[:id], with: "My Title"
        attach_file "Choose document", Rails.root.join("spec/fixtures/files/empty.pdf")

        expect(page).to have_css ".loading-bar.complete"
      end

      expect_document_has_title(0, "My Title")
    end

    scenario "Should update loading bar style after valid file upload" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))

      expect(page).to have_css ".loading-bar.complete"
    end

    scenario "Should update loading bar style after invalid file upload" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(
        Rails.root.join("spec/fixtures/files/logo_header.gif"),
        false
      )

      expect(page).to have_css ".loading-bar.errors"
    end

    scenario "Should update document cached_attachment field after valid file upload" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))

      expect_document_has_cached_attachment(0, ".pdf")
    end

    scenario "Should not update document cached_attachment field after invalid file upload" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(
        Rails.root.join("spec/fixtures/files/logo_header.gif"),
        false
      )

      expect_document_has_cached_attachment(0, "")
    end

    scenario "Should show document errors after documentable submit with
              empty document fields" do
      do_login_for user_to_login
      visit send(path, arguments)

      click_link "Add new document"
      click_on submit_button

      within "#nested-documents .document" do
        expect(page).to have_content("can't be blank", count: 2)
      end
    end

    scenario "Should delete document after valid file upload and click on remove button" do
      do_login_for user_to_login
      visit send(path, arguments)

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))
      click_link "Remove document"

      expect(page).not_to have_css("#nested-documents .document")
    end

    scenario "Should show successful notice when
              resource filled correctly without any nested documents" do
      do_login_for user_to_login
      visit send(path, arguments)

      send(fill_resource_method_name) if fill_resource_method_name
      click_on submit_button

      expect(page).to have_content documentable_success_notice
    end

    scenario "Should show successful notice when
              resource filled correctly and after valid file uploads" do
      do_login_for user_to_login
      visit send(path, arguments)
      send(fill_resource_method_name) if fill_resource_method_name

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))
      click_on submit_button

      expect(page).to have_content documentable_success_notice
    end

    scenario "Should show new document after successful creation with one uploaded file" do
      if documentable_factory_name == "dashboard_action"
        skip("Not render Documents count on dashboard_actions")
      end
      do_login_for user_to_login
      visit send(path, arguments)
      send(fill_resource_method_name) if fill_resource_method_name

      documentable_attach_new_file(Rails.root.join("spec/fixtures/files/empty.pdf"))
      click_on submit_button

      documentable_redirected_to_resource_show_or_navigate_to

      expect(page).to have_content "Documents"
      expect(page).to have_content "empty.pdf"

      # Review
      # Doble check why the file is stored with a name different to empty.pdf
      expect(page).to have_css("a[href$='.pdf']")
    end

    scenario "Should show resource with new document after successful creation with
              maximum allowed uploaded files" do
      if documentable_factory_name == "dashboard_action"
        skip("Not render Documents count on dashboard_actions")
      end
      do_login_for user_to_login
      visit send(path, arguments)

      send(fill_resource_method_name) if fill_resource_method_name

      %w[clippy empty logo].take(documentable.class.max_documents_allowed).each do |filename|
        documentable_attach_new_file(Rails.root.join("spec/fixtures/files/#{filename}.pdf"))
      end

      click_on submit_button
      documentable_redirected_to_resource_show_or_navigate_to

      expect(page).to have_content "Documents (#{documentable.class.max_documents_allowed})"
    end

    if path.include? "edit"
      scenario "Should show persisted documents and remove nested_field" do
        create(:document, documentable: documentable)
        do_login_for user_to_login
        visit send(path, arguments)

        expect(page).to have_css ".document", count: 1
      end

      scenario "Should not show add document button when
                documentable has reached maximum of documents allowed" do
        create_list(:document, documentable.class.max_documents_allowed, documentable: documentable)
        do_login_for user_to_login
        visit send(path, arguments)

        expect(page).not_to have_css "#new_document_link"
      end

      scenario "Should show add document button after destroy one document" do
        create_list(:document, documentable.class.max_documents_allowed, documentable: documentable)
        do_login_for user_to_login
        visit send(path, arguments)
        last_document = all("#nested-documents .document").last
        within last_document do
          click_on "Remove document"
        end

        expect(page).to have_css "#new_document_link"
      end

      scenario "Should remove nested field after remove document" do
        create(:document, documentable: documentable)
        do_login_for user_to_login
        visit send(path, arguments)
        click_on "Remove document"

        expect(page).not_to have_css ".document"
      end
    end

    describe "When allow attached documents setting is disabled" do
      before do
        Setting["feature.allow_attached_documents"] = false
      end

      scenario "Add new document button should not be available" do
        do_login_for user_to_login
        visit send(path, arguments)

        expect(page).not_to have_content("Add new document")
      end
    end
  end
end

def do_login_for(user)
  common_do_login_for(user, management: management)
end

def documentable_redirected_to_resource_show_or_navigate_to
  find("a", text: "Not now, go to my proposal")
  click_on "Not now, go to my proposal"
rescue
  nil
end

def documentable_attach_new_file(path, success = true)
  click_link "Add new document"

  document = all(".document").last
  attach_file "Choose document", path

  within document do
    if success
      expect(page).to have_css ".loading-bar.complete"
    else
      expect(page).to have_css ".loading-bar.errors"
    end
  end
end

def expect_document_has_title(index, title)
  document = all(".document")[index]

  within document do
    expect(find("input[name$='[title]']").value).to eq title
  end
end

def expect_document_has_cached_attachment(index, extension)
  document = all(".document")[index]

  within document do
    expect(find("input[name$='[cached_attachment]']", visible: :hidden).value).to end_with(extension)
  end
end

def documentable_fill_new_valid_proposal
  fill_in_new_proposal_title with: "Proposal title #{rand(9999)}"
  fill_in "Proposal summary", with: "Proposal summary"
  check :proposal_terms_of_service
end

def documentable_fill_new_valid_dashboard_action
  fill_in :dashboard_action_title, with: "Dashboard title"
  fill_in_ckeditor "Description", with: "Dashboard description"
end

def documentable_fill_new_valid_budget_investment
  fill_in_new_investment_title with: "Budget investment title"
  fill_in_ckeditor "Description", with: "Budget investment description"
  check :budget_investment_terms_of_service
end
