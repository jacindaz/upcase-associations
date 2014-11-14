require "rails_helper"

describe "root request" do
  it "shows a welcome message" do
    get "/"
    expect(response.body).to include("Welcome to My Guestbook")
  end
end
