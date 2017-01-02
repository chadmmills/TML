class RenameInvitationListToMailingList < ActiveRecord::Migration[5.0]
  def change
    rename_table :invitation_lists, :mailing_lists
  end
end
