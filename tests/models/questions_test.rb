require File.expand_path '../test_helper.rb', __dir__

class QuestionTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_question_must_has_name_no_null
    # Arrange
    question = Question.new

    # Act
    question.name = nil

    # Assert
    assert_equal(question.valid?, false)
  end

  def test_question_must_has_name_no_empty
    # Arrange
    question = Question.new

    # Act
    question.name = ''

    # Assert
    assert_equal(question.valid?, false)
  end

  def test_question_has_many_choices
    # Arrange
    question = Question.create(name: 'test', description: 'test', number: 1, type: 'test')
    choice1 = Choice.create(text: 'la choice', question_id: question.id)
    choice2 = Choice.create(text: 'la choice', question_id: question.id)
    choice3 = Choice.create(text: 'la choice', question_id: question.id)

    # Assert
    assert_equal(question.choices.count, 3)
  end

  def test_question_has_many_responses
    # Arrange
    question = Question.create(name: 'name_est', description: 'test', number: 1, type: 'test')
    survey = Survey.create(username: 'survey_test')
    choice = Choice.create(text: 'choice_test', question_id: question.id)
    response1 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)
    response2 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)
    response3 = Response.create(survey_id: survey.id, question_id: question.id, choice_id: choice.id)

    # Assert
    assert_equal(question.responses.count, 3)
  end
end
