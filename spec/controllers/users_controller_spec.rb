require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_successful
    end
  end

  context "#create" do
    let(:user) { FactoryGirl.build :user }
    it 'redirects back to root path after user creation' do
      #wrote this out longwinded was getting password_digest in params when passing in "params"
      #instead of password
      post :create, user: { username: user.username, password: user.password, email: user.email }
      expect(response).to redirect_to root_path
    end
    let(:user) { FactoryGirl.build :user }
    it 'user exists after create attempt' do
      expect {
        post :create, user: { username: user.username, password: user.password, email: user.email }
      }.to change{ User.count }.by(1)
      expect(response).to redirect_to root_path
    end
  end
end
