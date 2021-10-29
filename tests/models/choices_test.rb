require File.expand_path '../test_helper.rb', __dir__

class ChoiceTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_choice_must_has_text_no_null
    # Arrange
    choice = Choice.new

    # Act
    choice.text = nil

    # Assert
    assert_equal(choice.valid?, false)
  end

  def test_choice_must_has_text_no_empty
    # Arrange
    choice = Choice.new

    # Act
    choice.text = ''

    # Assert
    assert_equal(choice.valid?, false)
  end

  def test_choice_must_has_question
    # Arrange
    choice = Choice.new

    # Act
    choice.question_id = nil

    # Assert
    assert_equal(choice.valid?, false)
  end

  def test_choice_has_many_outcomes
    # Arrange
    career = Career.create(name: 'computacion')
    question = Question.create(name: 'question', description: 'testing question', number: 3, type: 'test')
    choice = Choice.create(text: 'test_choice', question_id: question.id)
    outcome1 = Outcome.create(career_id: career.id, choice_id: choice.id)
    outcome2 = Outcome.create(career_id: career.id, choice_id: choice.id)
    outcome2 = Outcome.create(career_id: career.id, choice_id: choice.id)

    # Assert
    assert_equal(choice.outcomes.count, 3)
  end

  def test_choice_has_many_responses
    # Arrange
    career = Career.create(name: 'career_test')
    question = Question.create(name: 'name_est', description: 'test', number: 1, type: 'test')
    survey = Survey.create(username: 'survey_test')
    choice = Choice.create(text: 'choice_test', question_id: question.id)
    response1 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)
    response2 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)
    response3 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)

    # Assert
    assert_equal(choice.responses.count, 3)
  end
end
