class Question < Sequel::Model
	one_to_many :choices
  one_to_many :responses

	def validate
		super
		errors.add(:name, 'cannot be empty') if !name || name.empty?
	end

	def validate
		super
		errors.add(:description, 'cannot be empty') if !description || description.empty?
	end
end
