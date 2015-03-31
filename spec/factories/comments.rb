FactoryGirl.define do
  factory :comment do
    association :post
    association :user
    content 'hello\n world'
  end
end
