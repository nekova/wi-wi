FactoryGirl.define do
  factory :comment do
    post nil
    user nil
    content 'hello\n world'
  end
end
