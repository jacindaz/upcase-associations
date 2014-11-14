require "rails_helper"

describe PagesController do
  describe "#index" do
    it "renders the welcome page" do
      get :index
      expect(response).to render_template("welcome")
    end
  end
end
