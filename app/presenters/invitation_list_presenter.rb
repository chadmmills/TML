class InvitationListPresenter
  attr_reader :invitation_list, :event

  def initialize(invitation_list)
    @invitation_list = invitation_list
    @event = invitation_list.event
  end

  delegate :title,
    to: :invitation_list

  delegate :event_title,
    to: :event
end
