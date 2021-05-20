class Career < Sequel::Model  
	one_to_many :outcomes
	one_to_many :surveys
end 