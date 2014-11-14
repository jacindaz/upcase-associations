class GuestbookEntriesController < ApplicationController
  def create
    @guestbook_entry = GuestbookEntry.new(guestbook_entry_params)

    if @guestbook_entry.save
      redirect_to root_path, notice: "Thank you for your entry."
    else
      @guestbook_entries = GuestbookEntry.most_recent_limited
      render "pages/welcome"
    end
  end

  private

  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:body)
  end
end
