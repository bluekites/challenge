require 'rails_helper'

describe CreativeQualitiesController do
  describe 'GET index' do 
    it 'gets the index' do 
      creative_qualities = []
      3.times do 
        creative_qualities.push(FactoryGirl.create(:creative_quality))
      end
      responses = []
      get :index 
      expect(response).to render_template('index')
      expect(assigns(:creative_qualities)).to eq(creative_qualities)
      expect(assigns(:responses)).to eq(responses)
    end
  end
end
