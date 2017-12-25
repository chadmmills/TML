class AddIsBlockedToMailingListContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :mailing_list_contacts, :is_blocked, :boolean, null: false, default: false
  end
end
