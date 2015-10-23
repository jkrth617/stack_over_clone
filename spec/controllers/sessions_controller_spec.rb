require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    let(:user) { FactoryGirl.create :user }
    it 'redirects back to root after creating session' do
      post :create, session: {:user => FactoryGirl.attributes_for(:user)}
      expect(response).to redirect_to login_path
    end
  end 
end
