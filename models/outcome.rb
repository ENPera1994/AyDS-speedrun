class Outcome < Sequel::Model
  many_to_one :careers
  many_to_one :choices
end
