class Score < Sequel::Model  
  many_to_one :careers
  many_to_one :surveys

  def validate
    super
    errors.add(:survey_id, 'cannot be empty')if !survey_id
    errors.add(:career_id, 'cannot be empty')if !career_id
  end

  #takes a collection of careers and an id and creates a Score object with
  #the given survey_id and career, for each career in the collection 
  #self makes the method static so we don't need an instance to invoke it
  def self.create_scores(careers, survey_id)
    careers.each do |career|
      score = Score.new(career_id: career.id, survey_id: survey_id)
      if score.save  #store score in database
		    [201, {'Location' => "scores/#{score.id}"}, 'Score succesfully created']
		  else
		    [500, {}, 'Internal Server Error']
		  end
    end
  end

  #takes a survey and retunrs an array with all the scored careers
  def self.get_careers(survey)
    careers = Array.new
    scores = survey.scores
    scores.each do |score|
      careers.append(Career.find(id: score.career_id))
    end
    return careers
  end

end