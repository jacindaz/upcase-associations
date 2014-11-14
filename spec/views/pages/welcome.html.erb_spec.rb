require "rails_helper"

describe "pages/welcome.html.erb" do
  before { assign(:guestbook_entry, GuestbookEntry.new) }

  it "displays the bodies of the guestbook entries" do
    assign(:guestbook_entries, [
      stub_entry(body: "food", created_at: Time.now),
      stub_entry(body: "barqs", created_at: Time.now)
    ])

    render

    expect(rendered).to have_content("food")
    expect(rendered).to have_content("barqs")
  end

  it "displays the timestamps of the guestbook entries" do
    assign(:guestbook_entries, [
      stub_entry(body: "hi", created_at: Time.parse("Nov 12 1955")),
      stub_entry(body: "bye", created_at: Time.parse("Oct 25 1985"))
    ])

    render

    expect(rendered).to have_content("Nov 12 1955")
    expect(rendered).to have_content("Oct 25 1985")
  end

  it "displays the error messages of an invalid form submission" do
    assign(:guestbook_entries, [])
    assign(:guestbook_entry, GuestbookEntry.new(body: "").tap(&:valid?))

    render

    expect(rendered).to have_content("Body can't be blank")
  end

  def stub_entry(attributes = {})
    double(GuestbookEntry, attributes.merge(likes: double(:likes, count: 0)))
  end
end
