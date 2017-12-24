class MailingListPresenter
  attr_reader :mailing_list, :event

  def initialize(mailing_list)
    @mailing_list = mailing_list
    @event = mailing_list.event
  end

  delegate :id, :title,
    to: :mailing_list

  delegate :event_title,
    to: :event

  def contacts
    Contact.
      joins("LEFT JOIN mailing_list_contacts ON mailing_list_contacts.contact_id = contacts.id AND mailing_list_contacts.mailing_list_id = #{id}").
      select("contacts.id, name, city, state, #{id} as list_id").
      select("is_complete, mailing_list_contacts.id as assignment_id").
      by_name
  end

  def non_added
    contacts.where(mailing_list_contacts: { id: nil })
  end
end
