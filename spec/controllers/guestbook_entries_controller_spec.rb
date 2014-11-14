require "rails_helper"

describe GuestbookEntriesController do
  describe "#create" do
    context "invalid entry" do
      it "renders the welcome view" do
        post :create, guestbook_entry: { body: "" }
        expect(response).to render_template "pages/welcome"
      end
    end

    context "valid entry" do
      it "sets the flash notice message" do
        post :create, guestbook_entry: { body: "something" }
        expect(flash[:notice]).to eq("Thank you for your entry.")
      end
    end
  end
end
