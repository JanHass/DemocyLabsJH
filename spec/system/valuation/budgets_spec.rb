require "rails_helper"

describe "Valuation budgets" do
  before do
    valuator = create(:valuator, user: create(:user, username: "Rachel", email: "rachel@valuators.org"))
    login_as(valuator.user)
  end

  context "Index" do
    scenario "Displaying budgets" do
      budget = create(:budget)
      visit valuation_budgets_path

      expect(page).to have_content(budget.name)
    end

    scenario "Filters by phase" do
      budget1 = create(:budget, :finished)
      budget2 = create(:budget, :finished)
      budget3 = create(:budget, :accepting)

      visit valuation_budgets_path

      expect(page).not_to have_content(budget1.name)
      expect(page).not_to have_content(budget2.name)
      expect(page).to have_content(budget3.name)
    end

    scenario "With no budgets" do
      visit valuation_budgets_path

      expect(page).to have_content "There are no budgets"
    end
  end
end
