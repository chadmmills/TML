class Event < ApplicationRecord

  scope :upcoming, -> { where("event_date > :date", date: Date.yesterday) }
  scope :in_the_past, -> { where("event_date < :date", date: Date.today) }
  scope :floating, -> { where(event_date: nil) }
end
