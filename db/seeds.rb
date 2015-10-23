# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(username: "coolkid", email:"test@example.com", password:"password")
User.create(username: "shaq", email:"test2@example.com", password:"password")

Question.create(user_id:1, title: "is jason too into toilets???", body: "I mean the kid does seem a little weird about the whole thing....")
Answer.create(body: "seems like it", user_id:2, question_id:2)


4.times do
  q = Question.create(user_id:1, title: Faker::Hacker.ingverb+"?", body: Faker::Hacker.say_something_smart+"???")
  4.times do
    Answer.create(question_id:q.id, user_id:2, body: Faker::Hacker.say_something_smart+"!")
  end
end
