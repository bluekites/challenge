module ApplicationHelper
  def mock_creative_quality_scores
    scores = [67, -25, 67]
    data = []

    CreativeQuality
      .limit(3)
      .each_with_index do |creative_quality, i|
      data << creative_quality.as_json.merge(
        score: scores[i]
      )
    end

    data
  end
  
  class NormalizedScores
    
    MIN = -100
    MAX = 100
    
    def initialize(responses, cq_name)
      @responses = responses
      @cq_name = cq_name
      @raw_score = 0
      @max_score = 0
    end
    
    def total_raw
      @responses.each do |r|
        @raw_score += r.raw_score(@cq_name)
      end
      return @raw_score
    end
    
    def total_max
      @responses.each do |r|
        @max_score += r.max_score(@cq_name)
      end
      return @max_score
    end
    
    def normalized_score
      score = ((total_raw.to_f / total_max.to_f) * 100).round
      if score < -100 then 
        return MIN
      elsif score > 100 then 
        return MAX
      end
      return score
    end
  end
end
