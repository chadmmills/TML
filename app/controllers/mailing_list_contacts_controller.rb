class MailingListContactsController < ApplicationController
  def create
    mailing_list_contact = MailingListContact.find_or_initialize_by(
      contact_id: params[:contact_id],
      mailing_list_id: params[:mailing_list_id],
      )
    mailing_list_contact.toggleAssignment!
    respond_to do |format|
      format.json { render json: {
          assignment_id: mailing_list_contact.assignment_id
        }
      }
    end
  end

  def update
    mailing_list_contact = MailingListContact.find(params[:id])
    mailing_list_contact.update!(
      params.require(:mailing_list_contact).permit(:is_complete, :is_blocked)
    )

    respond_to do |format|
      format.json { render json: mailing_list_contact }
    end
  end
end

