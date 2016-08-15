FactoryGirl.define do
  factory :event do
    sequence(:event_title) { |n| "This is Party #{n}" }
    event_date { 3.weeks.from_now }
  end
end
