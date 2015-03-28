include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :name do FFaker::Name.last_name.downcase end
  sequence :email do FFaker::Internet.email end
  sequence :password do FFaker::Internet.password end
  sequence :http_url do FFaker::Internet.uri("http") end
  sequence :https_url do FFaker::Internet.uri("https") end
end
