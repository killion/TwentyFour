# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    latitude 1.5
    longitude 1.5
    destination "MyString"
    user_id 1
  end
end
