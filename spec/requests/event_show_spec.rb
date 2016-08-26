require 'rails_helper'

RSpec.describe "EventShow" do
  it "should respond to the remote true request" do
    event = create :event

    get "/events/#{event.id}", xhr: true, as: :js

    expect(response.body).to include event.event_title
  end
end
