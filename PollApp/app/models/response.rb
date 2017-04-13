class Response < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: { scope: :answer_choice }
  validates :answer_choice_id, presence: true
  validate :respondent_already_answered?
  validate :respondent_is_author?

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll


  def sibling_responses
    unless @id.nil?
      return question.responses.where.not(response: {id: @id} )
    end
    question.responses
  end

  def respondent_already_answered?
    if sibling_responses.exists?(user_id: @user_id)
      errors[:user_id] << 'already responded.'
    end
  end

  def respondent_is_author?
    if poll.author_id == @user_id
      errors[:user_id] << 'cannot repond to own poll.'
    end
  end

end
