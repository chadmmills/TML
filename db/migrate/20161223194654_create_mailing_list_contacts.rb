class CreateMailingListContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :mailing_list_contacts do |t|
      t.references :mailing_list, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.references :contact, null: false, index: true, foreign_key: { on_delete: :cascade }
      t.boolean :is_complete, null: false, default: false

      t.timestamps
    end

    add_index :mailing_list_contacts, [:mailing_list_id, :contact_id], unique: true
  end
end
