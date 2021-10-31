require "rails_helper"

describe Admin::ActionComponent do
  describe "HTML class" do
    it "includes an HTML class for the action by default" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/")

      expect(page).to have_css "a.edit-link.admin-action"
    end

    it "keeps the admin-action class when the class is overwritten" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/", class: "modify-link")

      expect(page).to have_css "a.modify-link.admin-action"
      expect(page).not_to have_css ".edit-link"
    end
  end

  describe "aria-label attribute" do
    it "is not rendered by default" do
      record = double(human_name: "Stay home")

      render_inline Admin::ActionComponent.new(:edit, record, path: "/")

      expect(page).to have_link count: 1
      expect(page).not_to have_css "[aria-label]"
    end

    it "is not rendered when aria-label is nil" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/", "aria-label": nil)

      expect(page).to have_link count: 1
      expect(page).not_to have_css "[aria-label]"
    end

    it "renders with the given value" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/", "aria-label": "Modify")

      expect(page).to have_link count: 1
      expect(page).to have_css "[aria-label='Modify']"
    end

    context "when aria-label is true" do
      it "includes the action and the human_name of the record" do
        record = double(human_name: "Stay home")

        render_inline Admin::ActionComponent.new(:edit, record, path: "/", "aria-label": true)

        expect(page).to have_link count: 1
        expect(page).to have_css "a[aria-label='Edit Stay home']", exact_text: "Edit"
      end

      it "uses the to_s method when there's no human_name" do
        record = double(to_s: "do_not_go_out")

        render_inline Admin::ActionComponent.new(:edit, record, path: "/", "aria-label": true)

        expect(page).to have_link count: 1
        expect(page).to have_css "a[aria-label='Edit Do not go out']", exact_text: "Edit"
      end

      it "uses the human_name when there are both human_name and to_s" do
        record = double(human_name: "Stay home", to_s: "do_not_go_out")

        render_inline Admin::ActionComponent.new(:edit, record, path: "/", "aria-label": true)

        expect(page).to have_link count: 1
        expect(page).to have_css "a[aria-label='Edit Stay home']", exact_text: "Edit"
      end
    end
  end

  describe "data-confirm attribute" do
    it "is not rendered by default" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/")

      expect(page).to have_link count: 1
      expect(page).not_to have_css "[data-confirm]"
    end

    it "is not rendered when confirm is nil" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/", confirm: nil)

      expect(page).to have_link count: 1
      expect(page).not_to have_css "[data-confirm]"
    end

    it "renders with the given value" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/", confirm: "Really?")

      expect(page).to have_link count: 1
      expect(page).to have_css "[data-confirm='Really?']"
    end

    context "when confirm is true" do
      it "uses the human name as default" do
        record = double(human_name: "Everywhere and nowhere")
        text = 'Are you sure? Edit "Everywhere and nowhere"'

        render_inline Admin::ActionComponent.new(:edit, record, path: "/", confirm: true)

        expect(page).to have_link count: 1
        expect(page).to have_css "[data-confirm='#{text}']"
      end

      it "includes a more detailed message for the destroy action" do
        record = double(human_name: "Participatory Budget 2015")
        text = 'Are you sure? This action will delete "Participatory Budget 2015" and can\\\'t be undone.'

        render_inline Admin::ActionComponent.new(:destroy, record, path: "/", confirm: true)

        expect(page).to have_link count: 1
        expect(page).to have_css "[data-confirm='#{text}']"
      end
    end
  end

  describe "data-disable-with attribute" do
    it "is not rendered for links" do
      render_inline Admin::ActionComponent.new(:edit, double, path: "/")

      expect(page).not_to have_css "[data-disable-with]"
    end

    it "is rendered for buttons" do
      render_inline Admin::ActionComponent.new(:hide, double, path: "/", method: :delete)

      expect(page).to have_css "button[data-disable-with='Hide']"
    end
  end
end
