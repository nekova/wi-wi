FactoryGirl.define do
  factory :user do
    name
    email
    password
    password_confirmation { password }
  end

  sequence :name do
    (0...16).map { ('a'..'z').to_a[rand(26)] }.join
  end

  sequence :email do
    FFaker::Internet.email
  end

  sequence :password do
    FFaker::Internet.password
  end
end
