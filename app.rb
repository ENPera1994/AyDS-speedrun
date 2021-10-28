require './models/init.rb'

class App < Sinatra::Base
	get '/' do
		@consulted = false
		@username = params[:username]
		erb :landing
	end

	post '/' do
		@consulted = true	#to know in landing if user made a consult and show errors properly
		@career_count = Score.count_query(params[:first_date],params[:last_date],params[:career_name])
		@career_name = params[:career_name]
		
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
			if survey.completed  #the user has already done the test
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
		if !@survey.completed					#first time survey is completed
			@careers = @survey.result			#calculate survey result
			Score.create_scores(@careers,@survey.id)
		else		#in case survey has been completed and we are being redirected from the beginning
			@careers = Score.get_careers(@survey)
		end
		erb :result
	end

	post '/responses/:username' do
		survey = Survey.new(username: params[:username]) #survey created

		if survey.save  #store survey in database
			[201, {'Location' => "surveys/#{survey.id}"}, 'Survey succesfully created']
		else
			[500, {}, 'Internal Server Error']
		end

		Response.create_responses(params[:choice_id], survey.id)
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