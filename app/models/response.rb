class Response < ApplicationRecord
  has_many :question_responses

  validates :first_name, presence: true
  validates :last_name, presence: true

  delegate :count, to: :question_responses, prefix: true

  def display_name
    "#{first_name} #{last_name}"
  end

  def completed?
    question_responses_count == Question.count
  end
  
  def raw_score(cq_name)
    score = 0
    self.question_responses.each do |question_response|
      if question_response.question_choice.creative_quality.name == cq_name then 
        score += question_response.question_choice.score
      end
    end
    return score
  end
  
  def max_score(cq_name)
    score = 0
    # memoize
    max_scores = {}
    
    self.question_responses.each do |question_response|
      if max_scores[cq_name] then
        score = max_scores[cq_name]
      else 
        if question_response.question_choice.creative_quality.name == cq_name then 
          score += question_response.question.question_max
        end
      end
    end
    max_scores[cq_name] = score
    
    return score
  end
end
