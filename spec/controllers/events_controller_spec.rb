require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "GET #show" do
    it "should render only the action view not layout? " do
      event = create :event

      get :show, xhr: true, id: event.id
      pp response.body
      raise
    end
  end

end
