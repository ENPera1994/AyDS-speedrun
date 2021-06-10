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

        erb :careers_index
    end

    get '/careers/:id' do
        @career = Career.where(id: params['id']).last

        erb :career
    end

    post "/surveys" do
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
        if params[:id].to_i > Question.last.id 
            redirect "/resultado/#{params[:survey_id]}"
        end
        if Question.find(id: params[:id]).nil? 
            redirect to("/questions/#{(params[:id].to_i) + 1}?survey_id=#{params[:survey_id]}")
        end
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions
    end



    get '/resultado/:survey_id' do
        @survey = Survey.find(:id => params[:survey_id])
        hashCareer = Hash.new
        for i in Career.all
            hashCareer[i.id] = 0
        end
        
        for i in @survey.responses
            choice = Choice.find(id: i.choice_id)
            for l in choice.outcomes
                hashCareer[l.career_id] = hashCareer[l.career_id] + 1
            end
        end

        @survey.update(career_id: hashCareer.key(hashCareer.values.max))
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