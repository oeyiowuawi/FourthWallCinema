require "rails_helper"

describe Admin::ShowTimesController, type: :request do

  describe "PUT update" do
    context "when price is updated succesfully" do
      it "returns a success status" do
        user = create(:user, email: "eyiolekan@gmail.com")
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: DateTime.current + 1.day, price_cents: 20000)
        token = token_generator(user)
        headers = { 'Accept' => 'application/json', "AUTHORIZATION" => token }

        put "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { price_cents: "2999"},
              headers: headers

        expect(response).to have_http_status(200)
      end

      it "returns the correct price_cents" do
        user = create(:user, email: "eyiolekan@gmail.com")
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: DateTime.current + 1.day, price_cents: 20000, )
        token = token_generator(user)
        headers = { 'Accept' => 'application/json', "AUTHORIZATION" => token }
        put "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { price_cents: "2999"},
              headers: headers

        expect(json_response["show_time"]["price_cents"]).to eq(2999)
      end
    end

    context "when time is updated succesfully" do
      it "returns a success status" do
        user = create(:user, email: "eyiolekan@gmail.com")
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: DateTime.current + 1.day, price_cents: 20000)
        new_time = (DateTime.current + 2.day).to_s
        token = token_generator(user)
        headers = { 'Accept' => 'application/json', "AUTHORIZATION" => token }

        put "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { time: new_time },
              headers: headers

        expect(response).to have_http_status(200)
      end

      it "returns the correct time" do
        user = create(:user, email: "eyiolekan@gmail.com")
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: DateTime.current + 1.day, price_cents: 20000)
        new_time = (DateTime.current + 2.day).to_s
        token = token_generator(user)
        headers = { 'Accept' => 'application/json', "AUTHORIZATION" => token }

        put "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { time: new_time },
              headers: headers

        updated_show_time = json_response["show_time"]["time"].to_datetime
        expect(updated_show_time).to eq(new_time.to_datetime)
      end
    end

    context "when time is not successful" do
      it "returns the correct error message" do
        user = create(:user, email: "eyiolekan@gmail.com")
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: DateTime.current + 1.day, price_cents: 20000)
        new_time = (DateTime.current - 2.day).to_s
        token = token_generator(user)
        headers = { 'Accept' => 'application/json', "AUTHORIZATION" => token }

        put "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { time: new_time },
              headers: headers

        error = json_response["errors"]["time"]
        expect(error).to be_present
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end

  def token_generator(user)
    JsonWebToken.encode({ user_id: user.id }, 1.minutes.from_now)
  end
end