include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :name do FFaker::Name.name end
  sequence :email do FFaker::Internet.email end
  sequence :password do FFaker::Internet.password end
end
