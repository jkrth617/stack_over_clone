require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_success
    end
  end

  context "#create" do
    context "With valid credentials" do
      let :credentials do
        {:email => "bob@bob.com", username: "bob", password: "burgers" }
      end
     let :user do
       FactoryGirl.create(:user, credentials)
     end 

     before :each do
      post '/login', credentials
     end

     it 'creates a user session' do
      session[:user_id].should == user.id 
     end
    end
  end
end
