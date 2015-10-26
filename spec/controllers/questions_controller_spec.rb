require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  context "#new" do
    it 'response should be successful' do
      get :new
      expect(response).to be_successful
    end
  end

  context "#create" do
    let(:question) { FactoryGirl.build :question }
    let(:user) { FactoryGirl.create :user }
    xit 'redirects back to root path after question creation' do
      #wrote this out longwinded was getting password_digest in params when passing in "params"
      #instead of password
      post :create, question: { title: question.title, body: question.body }
      expect(response).to redirect_to root_path
    end
    it 'question does not exist after create attempt' do
      expect {
        post :create, question: { title: question.title, body: nil }
      }.to change{ Question.count }.by(0)
      expect(response).to redirect_to new_question_path
    end

    let(:question) { FactoryGirl.build :question }
    xit 'question exists after create attempt' do
      expect {
        post :create, question: { title: question.title, body: question.body }
      }.to change{ Question.count }.by(1)
      expect(response).to redirect_to root_path
    end
  end
end
