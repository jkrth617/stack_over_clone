require 'rails_helper'

RSpec.describe User, type: :model do
  context "#validations" do
    subject { User.new(password: '123456') }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of :password_digest }
    it { should validate_presence_of :email }
    it { should allow_value('shadi@devbootcamp.com').for(:email) }
  end

  context "#attributes" do
    let(:user) { FactoryGirl.build :user, :email => "shadi@dev.com" }
    it "it should save username" do
      user.save
      expect(user.reload.username).should_not be_nil
    end
    it "it should save password" do
      user.save
      expect(user.reload.password_digest).should_not be_nil
    end
    it "it should save email" do
      user.save
      expect(user.reload.email).should_not be_nil
    end
  end
end
