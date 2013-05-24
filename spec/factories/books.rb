# spec/factories/books.rb

require 'faker'

FactoryGirl.define do
  factory :book do |b|
    b.title { Faker::Name.name }
    b.author { Faker::Name.name }
    b.isbn { Faker::PhoneNumber.cell_phone }
  end

  factory :invalid_book, parent: :book do |b|
    b.title nil
  end
end
