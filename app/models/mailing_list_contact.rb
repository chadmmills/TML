class MailingListContact < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :contact

  # Attrs
  # - is_complete

  def self.not_complete_for_list(mailing_list)
    mailing_list.non_added.pluck(:id)
  end

  def assignment_id
    persisted? ? id : nil
  end

  def toggleAssignment!
    persisted? ? destroy! : save!
  end

  def toggleActionComplete!
    update!(is_complete: !read_attribute(:is_complete))
  end


  class On
    def initialize(list_id:, contact_ids:)
      @list_id = list_id
      @contact_ids = contact_ids
    end

    def toggle
      MailingListContact.transaction do
        contact_ids.each do |contact_id|
          MailingListContact.new(
            contact_id: contact_id,
            mailing_list_id: list_id,
          ).save!(validate: false)
        end
      end
    end

    private
    attr_reader :list_id, :contact_ids
  end

  class Off
    def initialize(list_id:, contact_ids:)
      @list_id = list_id
    end

    def toggle
      MailingListContact.
        where(mailing_list_id: list_id,
              is_complete: false).
              delete_all
    end

    private
    attr_reader :list_id
  end
end
