class Contact < ApplicationRecord
  attribute :is_complete, :boolean
  scope :by_name, -> { order(:name) }

  belongs_to :upload, optional: true
  has_many :mailing_list_contacts
  has_many :mailing_lists, through: :mailing_list_contacts
  has_many :versions, -> { order(:created_at) }, class_name: ContactVersion

  def self.new_from_csv_upload(csv_upload_contact)
    new(
      name: csv_upload_contact.name,
      street_1: csv_upload_contact.street_1,
      street_2: csv_upload_contact.street_2,
      city: csv_upload_contact.city,
      state: csv_upload_contact.state,
      zipcode: csv_upload_contact.zipcode,
      country: csv_upload_contact.country,
      upload: csv_upload_contact.upload,
    )
  end

  def full_address
    address_string = ""
    address_string += "#{street_1}" if street_1.present?
    address_string += " #{street_2}" if street_2.present?
    address_string += " #{city}" if city.present?
    address_string += " #{state}" if state.present?
    address_string += " #{zipcode}" if zipcode.present?
    address_string
  end
  alias :address :full_address

end
