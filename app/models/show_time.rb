class ShowTime < ApplicationRecord
  belongs_to :movie


  validates :price_cents, presence: true
  validates :movie_id, presence: true
  validates :time, presence: true
  validate :time_is_in_the_future
  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  scope :upcoming, -> { where("show_times.time > ?", DateTime.current)}

  private

  def time_is_in_the_future
    return false unless time.present?
    if DateTime.current > time.to_datetime
      errors.add(:time, "can't be in the past")
    end
  end
end
