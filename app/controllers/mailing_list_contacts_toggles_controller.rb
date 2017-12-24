class MailingListContactsTogglesController < ApplicationController
  def update
    respond_to do |format|
      toggler = params[:state] == 'on' ? MailingListContact::On : MailingListContact::Off
      mailing_list = MailingListPresenter.new(MailingList.find(params[:mailing_list_id]))

      toggler.new(
        list_id: mailing_list.id,
        contact_ids: MailingListContact.not_complete_for_list(mailing_list)
      ).toggle

      format.json do
        render json: { contacts: mailing_list.contacts }
      end
    end
  end
end
