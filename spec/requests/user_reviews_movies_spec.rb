require "rails_helper"

describe Customer::V1::ReviewsController, type: :request do
  describe "POST #create" do
    context "when the user data is correct" do
      it "creates a rating" do
        movie = create(:movie)

        expect do
          post "/customer/v1/movies/#{movie.slug}/reviews",
               params: { movie_id: movie.id, rating: 4 ,
                         comment: "Totally awesome."}, headers: {}
        end.to change(Review, :count).by(1)
      end
    end

    context "when the user data is not correct" do
      it "does not create a review" do
        movie = create(:movie)

        expect do
          post "/customer/v1/movies/#{movie.slug}/reviews",
               params: { movie_id: movie.id, rating: 6 ,
                         comment: "Totally awesome."}, headers: {}
        end.to change(Review, :count).by(0)
      end
    end
  end
end