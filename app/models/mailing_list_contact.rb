class MailingListContact < ApplicationRecord
  belongs_to :mailing_list
  belongs_to :contact

  # Attrs
  # - is_complete

  def assignment_id
    persisted? ? id : nil
  end

  def toggleAssignment!
    persisted? ? destroy! : save!
  end

  def toggleActionComplete!
    update!(is_complete: !read_attribute(:is_complete))
  end
end
