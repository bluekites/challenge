require 'rails_helper'

describe QuestionChoice do
  context 'associations' do
    it { is_expected.to belong_to(:question) }
    it { is_expected.to belong_to(:creative_quality) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :text }
    it { is_expected.to validate_presence_of :question }
    it { is_expected.to validate_presence_of :creative_quality }
    it { is_expected.to validate_numericality_of :score }
  end
  
  describe '#feedback' do 
    let (:question) {Question.new}
    let (:creative_quality) {CreativeQuality.new(name: 'kingdom hearts')}
    let (:question_choice) {QuestionChoice.new(text: 'test',
                                               question: question,
                                               creative_quality: creative_quality,
                                               score: 3)}
    
    it 'displays creative quality name and question choice score' do 
      expect(question_choice.feedback).to eql('kingdom hearts 3')
    end
  end
end
