FactoryGirl.define do
  factory :user do
    name { generate :name }
    email { generate :email }
    password { generate :password }
    password_confirmation { password }
  end
end
