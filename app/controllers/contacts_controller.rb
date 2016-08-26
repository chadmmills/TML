class ContactsController < ApplicationController
  def index
    render locals: {
      contacts: Contact.all.order(:name),
      last_upload: Upload.most_recent,
      recent_uploads: Upload.by_most_recent,
    }
  end

  def show
    render locals: { contact: contact }
  end

  private

  def contact
    @_contact ||= Contact.find(params[:id])
  end
end
