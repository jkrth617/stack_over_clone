require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_successful
    end
  end

  context "#create" do
    let(:user) { FactoryGirl.create :user }
    it 'redirects back to root path after user creation' do
      post :create, {:user => FactoryGirl.attributes_for(:user)}
      expect(response).to redirect_to root_path
    end
  end
end
