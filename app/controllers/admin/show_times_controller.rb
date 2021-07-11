class Admin::ShowTimesController < ApplicationController
  before_action :ensure_movie
  before_action :ensure_show_time

  def update
    if show_time.update(show_time_params)
      render json: { success: true, show_time: show_time }, status: 200
    else
      render json: { success: false, errors: show_time.errors }, status: 422
    end
  end

  private

  def show_time_params
    params.permit(:time, :price_cents)
  end

  def ensure_show_time
    unless show_time.present?
      render json: { success: false,
                     message: "Can not find Show time. Please provide the right details"},
            status: 404
    end
  end

  def ensure_movie
    unless movie.present?
      render json: { success: false, message: "Can not find movie. Please provide the right details"},
            status: 404
    end
  end

  def show_time
    @show_time ||= movie.show_times.find_by(params[:id])
  end

  def movie
    @movie ||= Movie.find_by(slug: params[:movie_id])
  end

end