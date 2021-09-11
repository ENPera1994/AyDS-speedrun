require File.expand_path '../../test_helper.rb', __FILE__

class CareerTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_career_has_many_surveys
    # Arrange
    career = Career.create(name: 'computacion')

    # Act
    Survey.create(username: '1', career_id: career.id)
    Survey.create(username: '2', career_id: career.id)
    Survey.create(username: '3', career_id: career.id)

    # Assert
    assert_equal(career.surveys.count, 3)
  end

  def test_career_has_many_outcomes

    #Arrange
    career = Career.create(name: 'Licenciado en Test')
    question = Question.create(name: 'test', description: 'test', number: 1, type: 'test')
    choice = Choice.create(text: 'la choice', question_id: question.id)
    outcome = Outcome.create(career_id: career.id, choice_id: choice.id)
    outcome2 = Outcome.create(career_id: career.id, choice_id: choice.id)
    outcome3 = Outcome.create(career_id: career.id, choice_id: choice.id)
    #Act

    #Assert
    assert_equal(career.outcomes.count, 3)
  end

  def test_career_has_name_no_null
   
    # Arrange
    career = Career.new

    # Act
    career.name = nil

    # Assert
    assert_equal(career.valid?, false)
  end

  def test_career_has_name_no_empty
   
    # Arrange
    career = Career.new

    # Act
    career.name = ''

    # Assert
    assert_equal(career.valid?, false)
  end
end
