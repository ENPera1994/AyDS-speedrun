require File.expand_path '../../test_helper.rb', __FILE__

class OutcomeTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase
  def test_outcome_has_a_career_and_a_choice
    # Arrange
    career = Career.create(name: 'borrada')
    question = Question.create(name: 'la question', description: 'testing question, should not appear in the database', number: 3, type: 'test')
    choice = Choice.create(text: 'la choice', question_id: question.id)
    # Act
    outcome = Outcome.create(career_id: career.id, choice_id: choice.id)
    # Assert
    assert_equal(outcome.valid?, true)
  
  end
end