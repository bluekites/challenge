class Question < ApplicationRecord
  has_many :question_choices, inverse_of: :question

  validates :title, presence: true

  accepts_nested_attributes_for(:question_choices)
  
  def question_max
    question_scores = []
    self.question_choices.each do |question_choice|
      question_scores.push(question_choice.score)
    end
    return question_scores.max
  end
end
