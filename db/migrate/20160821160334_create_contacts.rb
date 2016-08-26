class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
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
