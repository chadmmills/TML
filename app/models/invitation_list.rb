class InvitationList < ApplicationRecord
  belongs_to :event, required: true

  validates :title, presence: true
end
