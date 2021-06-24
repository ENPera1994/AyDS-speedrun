require './models/init.rb'

class App < Sinatra::Base
    get '/' do
        @username = params[:username]
        erb :landing
    end



    get "/hello/:name" do
        @name = params[:name]
        erb :hello_template
    end

    get "/careers" do
        @careers = Career.all
        @careers.shift      #first career which is used as default career_id in survey creation is removed

        erb :careers_index
    end

    get '/careers/:id' do
        @career = Career.where(id: params['id']).last

        erb :career
    end

    post "/surveys" do

        for survey in Survey.all  #destroys all surveys connected with null career, they must have been created
            if survey.career_id == Career.first.id &&  Time.now - survey.created_at >= 3600 #1 hour ago
                for response in survey.responses  #deletes every response asociated with the survey
                    response.destroy
                end
                survey.destroy
            end
        end

        data = request.body.read
        survey = Survey.find(username: params[:username]) #stores the survey with this username
        if survey.nil? || survey.career_id == Career.first.id  #if there was no such survey or the survey is assigned to null
            survey = Survey.new(username: params[:username], career_id: Career.first.id)    #career we create the new survey 
        else    #the user has already done the test
            redirect "/result/#{survey.id}"   #user is redirected to its result
        end
        if survey.save
            [201, {'Location' => "surveys/#{survey.id}"}, 'Survey succesfully created']
        else
            [500, {}, 'Internal Server Error']
        end
        redirect to("/questions?survey_id=#{survey.id}")   #the test starts
    end



    get '/questions' do
        @survey_id = params[:survey_id]
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

        @survey.update(career_id: hashCareer.key(hashCareer.values.max))  #sets the career with max count as career of the survey
        @career = Career.find(id: @survey.career_id)

        erb :result
    end


    post '/responses/:survey_id' do
        selected_choices = params[:choice_id]
        selected_choices.each do |id_choice| #for each choice_id in the parameters we get the question
            #it refeers to, create the response for that choice and load it in the database
            
            question_id = Choice.find(id: id_choice).question_id #using the choice id we have, we take the choice 
            #corresponding to id_choice and obtain from it the question_id it refers
            
            #ok, it seems that id_choice is an array, containing in [0] the id of the question it belongs to and
            #in [1] the id of the choice we selected for question in [0]
            response = Response.create(question_id: question_id, choice_id: id_choice[1], survey_id: params[:survey_id])
            
            if response.save
                [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']
            else
                [500, {}, 'Internal Server Error']
            end
        end

        redirect to("/result/#{params[:survey_id]}") #finally when all responses are created we go to see the result
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

    get '/posts' do
        p = Post.where(id: 1).last
        p.description
    end

end
