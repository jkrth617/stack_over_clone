require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "#login" do
    context "exists" do
      it 'response should be successful' do
        get :login_form
        expect(response).to be_success
      end
    end

    let(:user) { FactoryGirl.create :user }
    it 'redirects back to root after creating session' do
      post :login, session: {:user => FactoryGirl.attributes_for(:user), :params => { username: "shaq", password: "password" } }
      expect(response).to redirect_to login_path
    end

    context "when unsuccessful" do
      before(:each) do
        post :login, session: { username: 'nil', password: 'nil' }
      end

      it 'redirects to login page' do
        expect(response).to redirect_to login_path
      end

      it 'has no session set' do
        expect(session[:user_id]).to be_nil
      end
    end
    context "when success" do
      let(:user) { FactoryGirl.create :user }
      before(:each) do
        post :login, session: { :username => user.username, :password => user.password }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end

      it 'has session set' do
        expect(session[:user_id]).to_not be nil
      end
    end
  end
end
