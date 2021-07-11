class Customer::V1::ReviewsController < ApplicationController

  before_action :ensure_movie

  def create
    review = movie.reviews.new(review_params)
    if review.save
      render json: { success: true, review: review }, status: 201
    else
      render json: { success: false, errors: review.errors }, status: 422
    end
  end

  private

  def review_params
    params.permit(:rating, :comment)
  end

  def movie
    @movie ||= Movie.find_by(slug: params[:movie_id])
  end

  def ensure_movie
    unless movie.present?
      render json: { error: "Can not find movie." }, status: 404
    end
  end
end