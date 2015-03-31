FactoryGirl.define do
  factory :user do
    name
    email
    password
    password_confirmation { password }
  end

  sequence :name do
    FFaker::Name.last_name.downcase + rand(1..100).to_s
  end

  sequence :email do
    FFaker::Internet.email
  end

  sequence :password do
    FFaker::Internet.password
  end
end
