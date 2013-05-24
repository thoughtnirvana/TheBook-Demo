# spec/models/user_spec.rb
require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end

  it "is invalid without a name" do
    FactoryGirl.build(:user, name: nil).should_not be_valid
  end

  it "is invalid without an email" do
    FactoryGirl.build(:user, email: nil).should_not be_valid
  end

  it "has unique email" do
    FactoryGirl.create(:user, email: "a@b.com")
    FactoryGirl.build(:user, email: "a@b.com").should_not be_valid
  end

  it "validates email format" do
    FactoryGirl.build(:user, email: "abc").should_not be_valid
  end

  it "doesn't accept password of length less than 6 characters" do
    FactoryGirl.build(:user, password: "abc").should_not be_valid
  end
end
