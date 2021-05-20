class Survey < Sequel::Model
	many_to_many :careers
	one_to_many :responses
end
