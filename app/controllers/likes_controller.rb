class LikesController < ApplicationController

  def create
    @like = Like.new(like_params)
    @guestbook_entry = GuestbookEntry.find(params[:])

    if @like.save
      flash[:notice] = 'New like saved!'
      redirect_to root_path
    else
      flash[:notice] = 'Sorry, your like could not be saved.'
      render :'pages/welcome'
    end
  end

  private

  def like_params
    params.require(:like).permit(:num_likes)
  end
end
