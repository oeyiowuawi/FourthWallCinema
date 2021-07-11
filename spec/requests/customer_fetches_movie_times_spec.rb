require "rails_helper"

describe Customer::V1::MoviesController, type: :request do

  describe "GET #index" do
    it "returns the showtime and prices of movies that are yet to show" do
      movie = create(:movie, name: "F9", slug: "F9")
      date_time = DateTime.current + 2.days
      create(:show_time, movie: movie, price_cents: 1299, time: date_time)
      travel_to (DateTime.current - 2.days) do
        create(:show_time, movie: movie, price_cents: 1099, time: DateTime.current)
      end
      
      expected_result = { "movies" => [{ "name" => "F9",
                                          "show_times" => [
                                          { "time" => date_time.to_s(:time),
                                            "date" => date_time.to_date.to_s,
                                            "price" => "$12.99" 
                                          }]}]}
      headers = { 'Accept' => 'application/json' }

      get '/customer/v1/movies', params: {}, headers: headers

      expect(json_response).to eq(expected_result)
    end
  end

  describe "GET #show" do
    it "calls MovieDetail" do
      movie = create(:movie, name: "F9", slug: "F9")
      finder = MovieDetail.new(movie)
      allow(MovieDetail).to receive(:new).and_return(finder)
      allow(finder).to receive(:find).and_return(finder)
      allow(finder).to receive(:successful?).and_return(true)
      allow(finder).to receive(:result).and_return(
        { "Title"=>"The Fast and the Furious", "Year"=>"2001", "Rated"=>"PG-13",
         "Released"=>"22 Jun 2001", "Runtime"=>"106 min",
         "Genre"=>"Action, Crime, Thriller", "imdbRating"=>"6.8" }
      )

      get "/customer/v1/movies/#{movie.slug}", params: {}, headers: headers

      expect(finder).to have_received(:find)
    end

    context "when the Service TimesOut" do
      it "returns a 503 status code" do
        movie = create(:movie, name: "F9", slug: "F9")
        finder = MovieDetail.new(movie)
        allow(MovieDetail).to receive(:new).and_return(finder)
        allow(finder).to receive(:find).and_return(finder).and_raise(Timeout::Error)
        

        get "/customer/v1/movies/#{movie.slug}", params: {}, headers: headers

        expect(response).to have_http_status(503)
      end
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end