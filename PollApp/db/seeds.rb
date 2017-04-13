# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
    username = "John " + i.to_s
    user = User.create!(name: username)
    user2 = User.create!(name: "Jane #{i}")
    polltitle = "Meaning of Life "
    poll = Poll.create!(title: polltitle + i.to_s, author_id: user.id)

    pollquestion = "Why are you here? #{i}"
    question = Question.create!(text: pollquestion, poll_id: poll.id)

    answer = "God"
    answer2 = "Biology"
    answerchoice1 = AnswerChoice.create!(text: answer, question_id: question.id)
    answerchoice2 = AnswerChoice.create!(text: answer2, question_id: question.id)

    Response.create!(user_id: user.id, answer_choice_id: answerchoice1.id)
    Response.create!(user_id: user2.id, answer_choice_id: answerchoice2.id)
end
