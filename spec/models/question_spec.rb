require 'rails_helper'

describe Question do
  context 'associations' do
    it { is_expected.to have_many(:question_choices) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :title }
  end
  
  describe '#question_max' do 
    let (:question_choices) {[QuestionChoice.new(text: 'test',
                                               creative_quality: creative_quality,
                                               score: 2),
                              QuestionChoice.new(text: 'test2',
                                               creative_quality: creative_quality,
                                               score: 4)]}
    let (:question) {Question.new(question_choices: question_choices)}
    let (:creative_quality) {CreativeQuality.new(name: 'empowerment')}
    
    it 'should display the correct max score for a specific question choice' do 
      expect(question.question_max).to eql(4)
    end
  end
end
