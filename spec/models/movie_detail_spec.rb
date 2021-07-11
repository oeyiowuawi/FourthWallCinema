require "rails_helper"

describe MovieDetail do
  describe "#find" do
    context "when the ImdbService returns success data" do
      it "is successful" do
        movie = build_stubbed(:movie)
        service = ImdbService.new(movie_id: movie.imdb_id)
        allow(ImdbService).to receive(:new).and_return(service)
        allow(service).to receive(:get_movie_details).and_return(
          { success: true, data: [ {"Title" => "F9"} ] }
        )
        finder = MovieDetail.new(movie)

        finder.find

        expect(finder).to be_successful
      end
    end

    context "when ImdbService does not return success" do
      it "is not successful" do
        movie = build_stubbed(:movie)
        service = ImdbService.new(movie_id: movie.imdb_id)
        allow(ImdbService).to receive(:new).and_return(service)
        allow(service).to receive(:get_movie_details).and_return(
          { success: false}
        )
        finder = MovieDetail.new(movie)

        finder.find

        expect(finder).to_not be_successful
      end
    end
  end
end