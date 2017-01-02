class MailingListPresenter
  attr_reader :mailing_list, :event

  def initialize(mailing_list)
    @mailing_list = mailing_list
    @event = mailing_list.event
  end

  delegate :title,
    to: :mailing_list

  delegate :event_title,
    to: :event

  def contacts
    Contact.
      left_outer_joins(:mailing_list_contacts).
      select("contacts.id, name, city, state").
      select("is_complete, mailing_list_contacts.id as assignment_id").
      by_name
  end
end
