class MailingList < ApplicationRecord
  belongs_to :event, required: true

  validates :title, presence: true
end
