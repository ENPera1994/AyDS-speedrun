class Score < Sequel::Model  
  one_to_many :careers
  one_to_many :surveys

end