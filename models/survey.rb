class Survey < Sequel::Model
  one_to_many :scores
  one_to_many :responses

  def validate
    super
    errors.add(:username, 'cannot be empty') if !username || username.empty?
  end

  def before_destroy
    super
    responses.each(&:destroy)
    scores.each(&:destroy)
  end

  # calculates the best careers based on the responses
  # returns an array containing the best career and any other tied in score
  def result
    top_careers = [] # array for best careers
    hash_career = career_scores # obtain scores
    max_score = hash_career.values.max # score of best career

    if max_score.nil? # case of empty hashmap (no career scored)
      top_careers[0] = Career.first # null career
      return top_careers
    end

    # filter the hash leaving only the best and all careers tied in score with the best one
    hash_career.select! { |_key, value| value == max_score }

    hash_career.each_key do |career_id| # for every career id in hash
      top_careers.append(Career.find(id: career_id)) # load Career object with this id in the array
    end
    top_careers
  end

  # return a hashmap with career_id as key and score as value
  def career_scores
    hash_career = Hash.new(0) # create a hashmap for careers score initialized with 0

    responses.each do |response| # for every response to the current survey
      choice = Choice.find(id: response.choice_id) # choice selected as response
      choice.outcomes.each do |outcome| # for every outcome of the selected choices
        hash_career[outcome.career_id] += 1 # add 1 point to the career
      end
    end

    hash_career # if no career has scored, we get an emtpy hash
  end

  # returns true if the survey has been completed before and the first score doesn't have the null career
  def completed
    result = scores.first # we get the first score of the survey
    !result.nil? && result.career_id != Career.first.id # if there is a career and is not the null one, then
                                                        # survey has been completed
  end
end
