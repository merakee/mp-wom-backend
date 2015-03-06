# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_like do
    user 
    userid_liked {user_liked=user; user_liked.id}
  end
end
