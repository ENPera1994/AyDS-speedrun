class Survey < Sequel::Model
	many_to_one :careers
	one_to_many :responses
end
