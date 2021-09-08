class Survey < Sequel::Model
	many_to_one :careers
	one_to_many :responses

	def validate
    super
    errors.add(:username, 'cannot be empty') if !username || username.empty?
  end

  def before_destroy
    super
    for response in self.responses  #deletes every response asociated with the survey
      response.destroy
    end
  end
end
