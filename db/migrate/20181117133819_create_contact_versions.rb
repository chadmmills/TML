class CreateContactVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_versions do |t|
      t.references :contact, foreign_key: true
      t.string :name, null: false
      t.string :street_1, null: false
      t.string :street_2, default: ""
      t.string :city, null: false
      t.string :state, default: ""
      t.string :country, default: ""
      t.string :zipcode, default: ""

      t.timestamps
    end
  end
end
