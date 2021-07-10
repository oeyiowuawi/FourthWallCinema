class Customer::V1::MoviesController < ApplicationController

  def index
    movies = Movie.upcoming_movies
    binding.pry
    render json UpcomingMoviesSerializer.new(movies).to_json, status: 200
  end
end