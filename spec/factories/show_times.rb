FactoryBot.define do
  factory :show_time do
    movie
    time { DateTime.current + 1.day }
    price_cents { 1000 }
  end
end