class Contact < ApplicationRecord
  belongs_to :upload

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
    "#{street_1} #{city} #{state} #{zipcode}"
  end
end
