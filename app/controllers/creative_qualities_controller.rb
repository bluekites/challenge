class CreativeQualitiesController < ApplicationController
  def index
    @creative_qualities = CreativeQuality.all
    @responses = Response
      .includes(question_responses:[question_choice: [question: :question_choices]])
      .all
  end
end
