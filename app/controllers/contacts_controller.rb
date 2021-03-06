class ContactsController < ApplicationController
  def index
    respond_to do |f|
      f.json { render json: Contact.all.order(:name).as_json(methods: [:address]) }
      f.html do
        render locals: {
          contacts: Contact.all.order(:name),
          last_upload: Upload.most_recent,
          recent_uploads: Upload.by_most_recent,
        }
      end
    end
  end

  def show
    render locals: { contact: contact }
  end

  def new
    render locals: { contact: Contact.new }
  end

  def create
    new_contact = Contact.new(contact_params)
    if new_contact.save
      redirect_to new_contact
    else
      ap new_contact.errors
      render :new
    end
  end

  def update
    contact.attributes = contact_params
    is_new_version = contact.changed?

    if contact.save
      ContactVersioner.new(contact) if is_new_version
      render :show, locals: { contact: contact }, alert: "Updated"
    else
      render :show, locals: { contact: contact }
    end
  end

  def destroy
    contact.destroy!
    redirect_to contacts_path
  end

  private

  def contact
    @_contact ||= ContactForm.new(Contact.find(params[:id]), Contact.all.by_name.pluck(:id))
  end

  def contact_params
    params.require(:contact).permit(
      :name,
      :street_1,
      :street_2,
      :city,
      :state,
      :zipcode,
    )
  end


  class ContactForm < SimpleDelegator

    attr_reader :contact_ids, :contact_index

    def initialize(contact, contact_ids)
      super(contact)
      @contact_ids = contact_ids
      @contact_index = contact_ids.find_index(contact.id)
    end

    def next
      contact_ids[contact_index + 1]
    end

    def previous
      unless contact_index == 0
        contact_ids[contact_index - 1]
      end
    end
  end
end
