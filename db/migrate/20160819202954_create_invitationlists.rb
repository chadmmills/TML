class CreateMailinglists < ActiveRecord::Migration[5.0]
  def change
    create_table :mailing_lists do |t|
      t.string :title, null: false
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
