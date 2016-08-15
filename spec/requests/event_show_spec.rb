require 'rails_helper'

RSpec.describe "EventShow" do
  it "should respond to the remote true request" do
    event = create :event

    xhr :get, "/events/#{event.id}", format: :js

    expect(response.body).to include event.event_title
  end
end
