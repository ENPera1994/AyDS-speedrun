class Career < Sequel::Model  
	one_to_many :outcomes
	many_to_many :surveys
end 