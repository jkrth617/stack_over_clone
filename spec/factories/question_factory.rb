FactoryGirl.define do
  factory :question do
    title { 'How do you ' + Faker::Hacker.verb + '?' }
    body { 'im stuck on ' + Faker::Hacker.noun + '.' }
  end
end
