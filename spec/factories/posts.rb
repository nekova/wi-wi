FactoryGirl.define do
  factory :post do
    title 'title'
    url
    content 'hello\n world'
  end

  sequence :url do
    FFaker::Internet.uri("http")
  end
end
