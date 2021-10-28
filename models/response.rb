class Response < Sequel::Model
	many_to_one :survey
	many_to_one :question
	many_to_one :choice

	def validate
        super
        errors.add(:survey_id, 'cannot be empty')if !survey_id  
        errors.add(:question_id, 'cannot be empty')if !question_id 
        errors.add(:choice_id, 'cannot be empty')if !choice_id 
    end

    #for a given collection of choices, creates responses and saves them in database
    def self.create_responses(selected_choices, surveyId)
        selected_choices.each do |question_and_choice| 
            response = Response.create(question_id: question_and_choice[0], choice_id: question_and_choice[1], survey_id: surveyId)

            if response.save
                [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
            else
                [500, {}, 'Internal Server Error']
            end
        end
    end

end