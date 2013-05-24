# spec/models/book_spec.rb
require 'spec_helper'

describe Book do
  it "has a valid factory" do
    FactoryGirl.create(:book).should be_valid
  end

  it "is invalid without a title" do
    FactoryGirl.build(:book, title: nil).should_not be_valid
  end

  it "is invalid without an author" do
    FactoryGirl.build(:book, author: nil).should_not be_valid
  end

  it "is invalid without an isbn number" do
    FactoryGirl.build(:book, isbn: nil).should_not be_valid
  end

  it "has unique isbn number" do
    FactoryGirl.create(:book, isbn: "1111111111")
    FactoryGirl.build(:book, isbn: "1111111111").should_not be_valid
  end

  it "has a valid search function" do
    FactoryGirl.create(:book, title: "MyBook")
    FactoryGirl.create(:book, title: "YourBook")
    assert Book.search("My", 1).count == 1
  end
end
