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

    get "/test" do
        @questions = Question.all

        erb :test
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