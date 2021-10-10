class Career < Sequel::Model  
	one_to_many :outcomes
	one_to_many :scores

	def validate
        super
        errors.add(:name, 'cannot be empty')if !name || name.empty? 
    end
end 