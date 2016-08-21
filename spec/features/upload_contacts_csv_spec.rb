require 'rails_helper'

feature "Adding new contacts" do
  scenario "by uploading a CSV" do
    visit root_path
    click_link "New Contact"
    attach_file "contact_upload[csv_upload_file]", "#{Rails.root}/spec/fixtures/contacts.csv"
    click_button "Upload"

    expect(page).to have_content "successfully"
  end
end
