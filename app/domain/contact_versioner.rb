class ContactVersioner
  def initialize(contact)
    ContactVersion.new(
      name: contact.name,
      street_1: contact.street_1,
      street_2: contact.street_2,
      city: contact.city,
      state: contact.state,
      country: contact.country,
      zipcode: contact.zipcode,
      contact_id: contact.id,
    ).save!
  end
end
