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

  def update
    guestbook_entry = GuestbookEntry.find(params[:id])
    @like = guestbook_entry.like.increment(:num_likes)

    if @like.save
      flash[:notice] = 'New like saved!'
      redirect_to root_path
    else
      flash[:notice] = 'Sorry, your like could not be saved.'
      render :'pages/welcome'
    end
  end

  private

  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:body)
  end
end
