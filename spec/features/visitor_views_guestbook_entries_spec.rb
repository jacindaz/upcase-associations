require "rails_helper"

feature "Viewing guestbook entries" do
  scenario "can be seen if they were posted in the past 30 days" do
    create_recent_guestbook_entry("Hi from recently!")
    visit root_path

    expect(page).to have_content("Hi from recently!")
  end

  scenario "cannot be seen if they were posted more than 30 days ago" do
    create_old_guestbook_entry("Hi from a long time ago!")
    visit root_path

    expect(page).not_to have_content("Hi from a long time ago!")
  end

  scenario "only shows the 5 most recent entries" do
    (1..6).each { |n| create_recent_guestbook_entry("Entry #{n}") }
    visit root_path

    expect(page).to have_content("Entry 6")
    expect(page).to have_content("Entry 5")
    expect(page).to have_content("Entry 4")
    expect(page).to have_content("Entry 4")
    expect(page).to have_content("Entry 2")
    expect(page).not_to have_content("Entry 1")
  end

  def create_old_guestbook_entry(body)
    GuestbookEntry.create!(body: body, created_at: 50.days.ago)
  end

  def create_recent_guestbook_entry(body)
    GuestbookEntry.create!(body: body, created_at: 14.days.ago)
  end
end
