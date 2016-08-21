class CreateInvitationlists < ActiveRecord::Migration[5.0]
  def change
    create_table :invitation_lists do |t|
      t.string :title, null: false
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
