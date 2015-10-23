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

    context "when unsuccessful" do
      before(:each) do
        post :create, session: { username: 'nil', password: 'nil' }
      end

      it 'redirects to login page' do
        expect(response).to redirect_to login_path
      end

      it 'has no session set' do
        expect(session[:user_id]).to be_nil
      end
    end
  end 
end
