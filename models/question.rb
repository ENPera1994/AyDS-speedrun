class Question < Sequel::Model  
	one_to_many :choices
    one_to_many :responses
end 