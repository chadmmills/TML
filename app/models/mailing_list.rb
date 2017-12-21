class MailingList < ApplicationRecord
  belongs_to :event, required: true

  has_many :mailing_list_contacts
  has_many :contacts, through: :mailing_list_contacts

  validates :title, presence: true
end
