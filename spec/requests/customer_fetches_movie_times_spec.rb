require "rails_helper"

describe Customer::MoviesController, type: :request do

  describe "GET index" do
    it "returns the showtime and prices of movies that are yet to show" do
      movie = create(:movie, name: "F9", slug: "F9")
      date_time = DateTime.current + 2.days
      create(:show_time, movie: movie, price_cents: 1299, time: date_time)
      create(:show_time, movie: movie, price_cents: 1099, time: DateTime.current - 2.days)
      expected_result = { movies: { name: "F9",
                                    show_times: [{ time: date_time.to_s(:time),
                                                   date: date_time.to_date.to_s, price: "$12.99"}]}}
      headers = { 'Accept' => 'application/json' }

      get '/customer/v1/show_times', params: {}, headers: headers

      expect(result).to eq(expected_result)
    end
  end
end