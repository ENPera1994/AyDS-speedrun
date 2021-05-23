class Survey < Sequel::Model
	many_to_one :careers
	one_to_many :responses

	def validate
    super
    errors.add(:username, 'cannot be empty') if !username || username.empty?
  end
end
