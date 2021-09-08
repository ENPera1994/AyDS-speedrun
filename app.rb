require './models/init.rb'

class App < Sinatra::Base
	get '/' do
		@username = params[:username]
		erb :landing
	end

	get "/careers" do
		@careers = Career.all
		@careers.shift      #first career which is used as default career_id in survey creation is removed

		erb :careers_index
	end

	post "/careers" do
		data = request.body.read
		career = Career.new(name: params[:name], description: params[:description] || params['name', 'description'])

		if career.save
			[201, {'Location' => "careers/#{career.id}"}, 'Career succesfully created']
		else
			[500, {}, 'Internal Server Error']
		end
	end

	get '/careers/:id' do
		@career = Career.where(id: params['id']).last

		erb :career
	end

	post "/surveys" do
		data = request.body.read
		username = params[:username]
		survey = Survey.find(username: username) #looks for a survey with this username
		
		if !survey.nil? #such survey exists
			if survey.career_id != Career.first.id  #the user has already done the test
				redirect "/result/#{survey.id}"   #user is redirected to its result
			else
				survey.destroy #it has the null career, so we restart its test
			end
		end
		
		redirect to("/questions?username=#{username}")   #the test starts
	end

	get '/questions' do
		@username = params[:username]
		@questions = Question.all
		erb :questions  #shows each question whit its choices
	end

	get '/result/:survey_id' do
		@survey = Survey.find(:id => params[:survey_id])
		hashCareer = Hash.new
		for career in Career.all  #creates a hashmap for careers, using id as key and a count as value
			hashCareer[career.id] = 0   #initializes every career count as 0
		end

		for response in @survey.responses   #for every response to the current survey
			choice = Choice.find(id: response.choice_id)    #choice selected as response
			for outcome in choice.outcomes      #for every outcome of the selected choices, add 1 to the career
				hashCareer[outcome.career_id] = hashCareer[outcome.career_id] + 1   #count in the hashmap
			end
		end


		@survey.update(career_id: hashCareer.key(hashCareer.values.max))  #we stablish the career with the max value
																		  # in the hash as the survey career_id

		#we filter the hash leaving only the items whose value is equal to the max value in the hash, their values
		# are not 0 and that are not the career we asociated to the survey
		hashCareer.select! {|key,value| value == hashCareer.values.max && value != 0 && key != @survey.career_id }
		
		@careers = Array.new    #we create a new array to load careers on it
		@careers[0] = Career.find(id: @survey.career_id) #we store the career asociated with the survey, this is
		#just in case all values were 0, in that case we would only want to show the auxiliar career (Career.first)
		
		careerCount = hashCareer.to_a #we transform the hash into an array of arrays with key as first value and 
																				#value as the second element
		i = 1
		careerCount.each do |id_count|
			@careers[i] = Career.find(id: id_count[0]) 
			i += 1
		end

		erb :result
	end

	post '/responses/:username' do
		survey = Survey.new(username: params[:username], career_id: Career.first.id) #we create the survey with the null
																																								 #career temporarily
		if survey.save  #store survey in database
		    [201, {'Location' => "surveys/#{survey.id}"}, 'Survey succesfully created']
		else
		    [500, {}, 'Internal Server Error']
		end

		selected_choices = params[:choice_id] #array of arrays of ids (first is of question and second of choice)
		selected_choices.each do |question_and_choice| #for each choice_id and the question it refeers to, we will
			#create the response and load it in the database
			
			response = Response.create(question_id: question_and_choice[0], choice_id: question_and_choice[1], survey_id: survey.id)
			
			if response.save
				[201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
			else
				[500, {}, 'Internal Server Error']
			end
		end
		
		redirect to("/result/#{survey.id}") #finally when all responses are created we go to see the result
	end

	get '/posts' do
		p = Post.where(id: 1).last
		p.description
	end

	post "/posts" do
		request.body.rewind  # in case someone already read it
		data = JSON.parse request.body.read
		post = Post.new(description: data['desc'])
		if post.save
			[201, { 'Location' => "posts/#{post.id}" }, 'CREATED']
		else
			[500, {}, 'Internal Server Error']
		end
	end

end