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
        survey = Survey.new(username: params[:username])

        if survey.save
            [201, {'Location' => "surveys/#{survey.id}"}, 'Survey succesfully created']
        else
            [500, {}, 'Internal Server Error']
        end
        redirect to("/questions/#{Question.first.id}?survey_id=#{survey.id}")
    end

    

    get '/questions/:id' do
        if params[:id].to_i > Question.last.id #Check if the last question was asked 
            redirect "/finish/#{params[:survey_id]}"
        end
        if Question.find(id: params[:id]).nil? #Check if the currect question(id) is nil
            redirect to("/questions/#{(params[:id].to_i) + 1}?survey_id=#{params[:survey_id]}")
        end
    @question = Question.find(id: params[:id])
    @survey_id = params[:survey_id]
    erb :questions
    end

#    get "/test" do
#        @questions = Question.all

#        erb :test
#    end

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