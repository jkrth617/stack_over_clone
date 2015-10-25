# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  name = Faker::Name.first_name
  email = Faker::Internet.email(name)

  User.create(username: name, email: email, password:"password")
end
User.create(username: "shaq", email:"shaq@attack.com", password:"password")
user_count = User.all.count
user = User.find(rand(user_count)+1)
Question.create(user_id: user, title: "is jason too into toilets???", body: "I mean the kid does seem a little weird about the whole thing....")
Answer.create(body: "seems like it", user_id: user, question_id: 1)
count = 50
puts "seeding #{count} questions."
count.times do
  user = User.find(rand(user_count)+1)

  q = Question.create(user_id: user.id, title: "How do you "+ Faker::Hacker.verb + " a " + Faker::Hacker.noun+"?",
   body: "My " + Faker::Hacker.noun + " is " + Faker::Hacker.verb + ".\n" + Faker::Lorem.sentence(random_words_to_add = 1)+"\n")

  2.times do
    q.tags << Tag.create(description: Faker::Hacker.noun)
  end

  q.tags << Tag.create(description: Faker::Hacker.verb)

  8.times do
    Answer.create(question_id:q.id, user_id: user.id, body: Faker::Hacker.say_something_smart+"!")
  end
end
