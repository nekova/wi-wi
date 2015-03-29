include ActionDispatch::TestProcess

FactoryGirl.define do
  sequence :http_url do FFaker::Internet.uri("http") end
  sequence :https_url do FFaker::Internet.uri("https") end
end
