require 'rails_helper'

feature "Creating an event" do
  scenario "User can create an event through form" do
    visit root_path
    click_link "New Event"
    fill_in "Event Title", with: "Jack Birthday"
    click_button "Create Event"

    expect(page).to have_css "div", text: "Jack Birthday"

    click_link "Jack Birthday"
    click_link "New Invitation List"
  end
end
