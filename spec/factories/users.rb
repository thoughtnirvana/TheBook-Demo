# spec/factories/users.rb

require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    password = Faker::Name.first_name + Faker::PhoneNumber.cell_phone
    f.password { password }
    f.password_confirmation { password }
  end

  factory :admin, parent: :user do |f|
    f.admin { true }
  end
end
