class Question < ActiveRecord::Base
  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    hash = {}
    answer_choices_with_counts = self
      .answer_choices
      .joins('LEFT JOIN responses ON answer_choices.id = responses.answer_choice_id')
      .select("answer_choices.text, COALESCE(COUNT(responses.id), 0) AS response_count")
      .group(answer_choices: :id)

    answer_choices_with_counts.each do |answer_choice|
      hash[answer_choice.text] = answer_choice.response_count
    end
    hash
  end


end
