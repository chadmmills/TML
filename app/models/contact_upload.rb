require 'csv'

class ContactUpload
  include ActiveModel::Model

  attr_accessor :csv_upload_file
  attr_reader :csv_contacts

  def upload
    return false unless generate_contacts_from_rows
    return false unless insert_valid_contacts_into_db
    return false if invalid_contacts_in_upload?
    true
  end

  def generate_contacts_from_rows
    @csv_contacts = CSV.foreach(csv_upload_file.path).map do |row|
      CSVContactRow.new(row, upload_log)
    end
    @csv_contacts
  end

  def valid_csv_contacts
    @_valid_contacts ||= csv_contacts.select(&:valid?)
  end

  def invalid_csv_contacts
    @_invalid_contacts ||= csv_contacts.select(&:invalid?)
  end

  def invalid_contacts_in_upload?
    invalid_csv_contacts.any?
  end

  def insert_valid_contacts_into_db
    ActiveRecord::Base.transaction do
      upload_log.save!
      valid_csv_contacts.each do |contact|
        contact.save!
      end
    end
  end

  def upload_log
    @_upload ||= Upload.new
  end

  class CSVContactRow
    attr_reader :attrs, :contact_class, :upload
    def initialize(attrs, upload, contact=Contact)
      @attrs = attrs
      @upload = upload
      @contact_class = contact
    end

    delegate(
      :valid?,
      :invalid?,
      :save!,
      to: :contact
    )

    def contact
      @contact ||= contact_class.new_from_csv_upload(self)
    end

    def name
      attrs[0]
    end

    def street_1
      attrs[1]
    end

    def street_2
      ""
    end

    def city
      attrs[2]
    end

    def state
      attrs[3]
    end

    def zipcode
      attrs[4]
    end

    def country
      ""
    end

  end
end
