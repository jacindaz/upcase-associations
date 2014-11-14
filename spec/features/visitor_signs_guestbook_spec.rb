require "rails_helper"

feature "A visitor signs the guestbook" do
  scenario "and sees their entry on the welcome page" do
    visit root_path
    fill_in "Guestbook Entry:", with: "Hey! Awesome site."
    click_button "Submit"

    expect(page).to have_content "Thank you for your entry."

    within "div#guestbook-entries" do
      expect(page).to have_content "Hey! Awesome site."
    end
  end

  scenario "with an invalid entry and sees an error message" do
    visit root_path
    fill_in "Guestbook Entry:", with: "Invalid because it has the word silly."
    click_button "Submit"

    expect(page).to have_content "Body contains a bad word"

    within "div#guestbook-entries" do
      expect(page).not_to have_content "Invalid because it has the word silly."
    end
  end
end
