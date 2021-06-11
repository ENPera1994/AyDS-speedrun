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

        for survey in Survey.all
          if survey.career_id == Career.first.id &&  Time.now - survey.created_at >= 3600
              for response in survey.responses
                  response.destroy
              end
              survey.destroy
          end
        end

        data = request.body.read
        survey = Survey.new(username: params[:username], career_id: Career.first.id)

        if survey.save
            [201, {'Location' => "surveys/#{survey.id}"}, 'Survey succesfully created']
        else
            [500, {}, 'Internal Server Error']
        end
        redirect to("/questions/#{Question.first.id}?survey_id=#{survey.id}")
    end



    get '/questions/:id' do
        if params[:id].to_i > Question.last.id  #checks if there is no more questions to answer
            redirect "/resultado/#{params[:survey_id]}"
        end
        if Question.find(id: params[:id]).nil? #if this question_id doesn't belong to any question
            redirect to("/questions/#{(params[:id].to_i) + 1}?survey_id=#{params[:survey_id]}") #try with question_id + 1
        end
        @question = Question.find(id: params[:id])
        @survey_id = params[:survey_id]
        erb :questions
    end



    get '/resultado/:survey_id' do
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

        erb :resultado
    end


    post '/responses/:survey_id' do
        response = Response.create(question_id: params[:question_id], choice_id: params[:choice_id], survey_id: params[:survey_id])
        if response.save
            [201, { 'Location' => "responses/#{response.id}" }, 'CREATED']

            redirect to("/questions/#{((response.question_id) + 1)}?survey_id=#{params[:survey_id]}")
        else
            [500, {}, 'Internal Server Error']
        end
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

    get '/resultado/:survey_id' do
        erb :resultado
    end

end
