FactoryGirl.define do
  factory :user do
    name
    email
    password
    password_confirmation { password }
  end

  sequence :name do
    FFaker::Name.last_name.downcase + FFaker::Name.first_name.downcase
  end

  sequence :email do
    FFaker::Internet.email
  end

  sequence :password do
    FFaker::Internet.password
  end
end
