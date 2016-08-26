class ContactUploadsController < ApplicationController
  def create
    if contact_upload.upload
      redirect_to contacts_path, success: "Contacts uploaded successfully"
    else
      render "contacts/index", locals: {
        contacts: Contact.all,
        last_upload: Upload.most_recent,
      }
    end
  end

  private

  def contact_upload
    @_contact_upload ||= ContactUpload.new(upload_file)
  end

  def upload_file
    params.require(:contact_upload).permit(:csv_upload_file)
  end
end
