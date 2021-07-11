class Review < ApplicationRecord
  belongs_to :movie

  validates :movie_id, presence: true
  validates :rating, numericality: { greater_than: 0, less_than: 6, only_integer: true }
end
