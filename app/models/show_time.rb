class ShowTime < ApplicationRecord
  belongs_to :movie

  monetize :price_cents

  validates :price_cents, presence: true
  validates :movie_id, presence: true
  validates :time, presence: true
  validate :time_is_in_the_future

  private

  def time_is_in_the_future
    return false unless time.present?
    if DateTime.current > time
      errors.add(:time, "can't be in the past")
    end
  end
end
