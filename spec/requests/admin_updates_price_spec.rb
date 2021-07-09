require "rails_helper"

describe Admin::ShowTimesController, type: :request do

  describe "PUT update" do
    context "when price is updated succesfully" do
      it "returns a sucess status" do
        movie = create(:movie, name: "F9", slug: "family-9")
        show_time = create(:show_time, movie: movie, time: "2pm", price_cent: 20000, )
        headers = { 'Accept' => 'application/json' }

        post "/admin/movies/#{movie.slug}/show_times/#{show_time.id}",
              params: { price_cent: "2999"}
              headers: headers
        
        expect(response).to have_http_code(200)
      end
    end
  end
end