require "rails_helper"

describe "routes" do
  it "routes '/' to the index action of the pages controller" do
    expect(get: "/").to route_to(controller: "pages", action: "index")
  end
end
