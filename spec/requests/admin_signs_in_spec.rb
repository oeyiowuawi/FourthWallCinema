require "rails_helper"

describe Admin::SessionsController do

  describe "POST #create" do
    context "when the password and email are correct" do
      it "returns the token" do
        user = create(:user, password: "#GoodPassword1", email: "eyiolekan@gmail.com")

        post "/admin/sessions", params: { email: user.email, password: "#GoodPassword1" },
                                headers: {}

        json_response = JSON.parse(response.body)
        expect(json_response["token"]).to be_present
      end
    end

    context "when the password and email are not correct" do
      it "returns the token" do
        user = create(:user, password: "#GoodPassword1", email: "eyiolekan@gmail.com")

        post "/admin/sessions", params: { email: user.email, password: "#GoodPassword" },
                                headers: {}

        json_response = JSON.parse(response.body)
        expect(json_response["token"]).not_to be_present
      end
    end
  end
end