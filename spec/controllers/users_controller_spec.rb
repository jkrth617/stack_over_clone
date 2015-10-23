require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_successful
    end
  end
end
