require 'rails_helper'

feature "Creating an mailing list" do
  scenario "User can create an mailing list on an event" do
    create :event, event_title: "John Doe Bday"

    visit root_path
    click_link "John Doe Bday"
    click_link "New"
    click_button "Create"
    expect(page).to have_content "Title can't be blank"
    fill_in "Title", with: "Bday Invite List"
    click_button "Create"
    expect(page).to have_content "Who would you like to invite to John Doe Bday?"
  end
end
