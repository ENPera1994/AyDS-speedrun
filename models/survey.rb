class Survey < Sequel::Model
	one_to_many :scores
	one_to_many :responses

	def validate
    super
    errors.add(:username, 'cannot be empty') if !username || username.empty?
  end

  def before_destroy
    super
    for response in self.responses  #deletes every response asociated with the survey
      response.destroy
    end
    for score in self.scores  #deltes scores
      score.destroy
    end
  end

  #calculates the best careers based on the responses
  #returns an array containing the best career and any other tied in score
  def result
    topCareers = Array.new #array for best careers
    hashCareer = self.career_scores   #obtain scores
    maxScore = hashCareer.values.max  #score of best career
    
    if maxScore.nil? #case of empty hashmap (no career scored)
      topCareers[0] = Career.first  #null career
      return topCareers
    end

    #filter the hash leaving only the best and all careers tied in score with the best one
    hashCareer.select! {|key,value| value == maxScore}
    
    hashCareer.keys.each do |career_id| #for every career id in hash
      topCareers.append(Career.find(id: career_id)) #load Career object with this id in the array
    end
    return topCareers
  end

  #return a hashmap with career_id as key and score as value
  def career_scores
    hashCareer = Hash.new(0)  #create a hashmap for careers score initialized with 0
    
    for response in self.responses   #for every response to the current survey
			choice = Choice.find(id: response.choice_id)    #choice selected as response
			for outcome in choice.outcomes      #for every outcome of the selected choices
				hashCareer[outcome.career_id] += 1   #add 1 point to the career
			end
		end
    
    return hashCareer   #if no career has scored, we get an emtpy hash
  end

  #for a given collection of choices, creates responses and saves them in database
  def create_responses(selected_choices)
    selected_choices.each do |question_and_choice| 
      response = Response.create(question_id: question_and_choice[0], choice_id: question_and_choice[1], survey_id: self.id)
      
      if response.save
        [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
      else
        [500, {}, 'Internal Server Error']
      end
    end
  end

  #returns true if the survey has been completed before and the first score doesn't have the null career
  def completed
    result = self.scores.first() #we get the first score of the survey
    return result != nil && result.career_id != Career.first.id  #if there is a career and is not the null one, then 
  end                                                            #survey has been completed

end
