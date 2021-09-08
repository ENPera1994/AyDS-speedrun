class Survey < Sequel::Model
	many_to_one :careers
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
  end

  def result   #return an array with Career object, the best career and any other tied in score
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
      topCareers.append(Career.find(id: career_id)) #load Career object with this id
    end
    return topCareers
  end

  def career_scores   #return a hashmap with career_id as key and score as value
    hashCareer = Hash.new(0)  #create a hashmap for careers score initialized with 0
    
    for response in self.responses   #for every response to the current survey
			choice = Choice.find(id: response.choice_id)    #choice selected as response
			for outcome in choice.outcomes      #for every outcome of the selected choices
				hashCareer[outcome.career_id] += 1   #add 1 point to the career
			end
		end
    
    return hashCareer   #if no career has scored, we get an emtpy hash
  end
end
