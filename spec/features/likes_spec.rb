require "rails_helper"

feature "A visitor likes an entry" do
  scenario "and sees the like count increase for that entry only" do
    visit root_path
    fill_in "Guestbook Entry:", with: "Unlikable entry."
    click_button "Submit"

    fill_in "Guestbook Entry:", with: "Likable entry."
    click_button "Submit"

    like_most_recent_entry

    within first("div#guestbook-entries ul li") do
      expect(page).to have_content("1 Like")
    end

    within ("div#guestbook-entries ul li:last-child") do
      expect(page).to have_content("0 Likes")
    end

    # Let's like it again!
    like_most_recent_entry

    within first("div#guestbook-entries ul li") do
      expect(page).to have_content("2 Likes")
    end

    within ("div#guestbook-entries ul li:last-child") do
      expect(page).to have_content("0 Likes")
    end
  end

  def like_most_recent_entry
    within first("div#guestbook-entries ul li") do
      click_button "Like"
    end
  end
end
