require './models/init.rb'

class App < Sinatra::Base
  get '/' do                             
    erb :landing
  end

  get "/hello/:name" do
    @name = params[:name]
    erb :hello_template
  end

  get "/careers" do
    @career = Career.all
    
    erb :careers_index
  end

  get '/careers/:id' do
    career = Career.where(id: params['id']).last

    "<ul>"
    "<li> id: #{career.id}" + 
    "<li> name: #{career.name}" + 
    "<li> surveys count: #{career.surveys.count}" + 
    "<li> description: #{career.description}" + 
    "</ul>"
  end

  #not working yet, the idea is to show every question with all its attributes
  # and below each question show the choices available with a checkbox
  get "/test" do
    @question = Question.all
    @choice = Choice.all
    q = @question.map { |question| "<li>" + question.number.to_s + "- " + question.name +
    "<li>" + question.description + "<li>" + "type: " + question.type + "<li>" +
    (@choice.select { |c| c.question_id == question.id }.map { |choice| "<li>" + #the problem is in this line, i'm trying to concatenate an array with a string (which is not possible)
    form = "<form>"                                                              
    form += "<input type='checkbox' name='choice.text' value='choice.text'>"
    form += "</form>" 
    }) }
    #after this we should make something for saving the choices the user selects and asociating them with the corresponding classes
    #also we need to store the username at the beggining of the test
  end

  post "/careers" do
  	data = request.body.read
    career = Career.new(name: params[:name], description: params[:description] || params['name', 'description']) 

  	if career.save
  		[201, {'Location' => "careers/#{career.id}"}, 'CREATED']
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

