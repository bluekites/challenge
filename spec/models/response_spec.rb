require 'rails_helper'

describe Response do
  context 'associations' do
    it { is_expected.to have_many(:question_responses) }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

  describe '#display_name' do
    let(:response) { Response.new(first_name: 'Tal', last_name: 'Safran') }

    it 'concatenates the first and last name' do
      expect(response.display_name).to eql('Tal Safran')
    end
  end

  describe '#completed?' do
    let(:response) { Response.new }

    before do
      allow(Question).to receive(:count).and_return(3)
      allow(response).to receive_message_chain(:question_responses, :count)
        .and_return(response_count)
    end

    context 'when no responses exist' do
      let(:response_count) { 0 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when some responses exist' do
      let(:response_count) { 1 }
      it 'is false' do
        expect(response.completed?).to be(false)
      end
    end

    context 'when responses exist for all questions' do
      let(:response_count) { 3 }
      it 'is true' do
        expect(response.completed?).to be(true)
      end
    end
  end
  
  context 'score calculations' do
    let(:creative_quality) {CreativeQuality.new(name: 'empowerment')}
    
    let(:question) {Question.new}
                     
    let(:question_choices) {[QuestionChoice.new(text: 'test',
                                               question: question,
                                               creative_quality: creative_quality,
                                               score: 2),
                             QuestionChoice.new(text: 'test2',
                                               question: question,
                                               creative_quality: creative_quality,
                                               score: 4)]}
    
    let(:question_response) {QuestionResponse.new(question_choice: question_choices[0])}
    
    let(:response) { Response.new(question_responses: [question_response])}
                           
    describe '#raw_score' do 
      it 'gets the correct raw score from question choices' do 
        question.question_choices = question_choices
        expect(response.raw_score('empowerment')).to eql(2)
      end
    end
    
    describe '#max_score' do 
      it 'gets the max score from question choices' do 
        question.question_choices = question_choices
        expect(response.max_score('empowerment')).to eql(4)
      end
    end
  end
end
