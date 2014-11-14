class PagesController < ApplicationController
  def index
    @guestbook_entries = GuestbookEntry.most_recent_limited
    @guestbook_entry = GuestbookEntry.new
    render "welcome"
  end
end
