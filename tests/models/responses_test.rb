require File.expand_path '../test_helper.rb', __dir__

class ResponseTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_response_must_has_choice_question_and_survey
    career = Career.create(name: 'test')
    question = Question.create(name: 'name_est', description: 'test', number: 1, type: 'test')
    choice = Choice.create(text: 'choice_test', question_id: question.id)
    survey = Survey.create(username: 'Pepe')
    response = Response.new

    # Response has choice_id but not question_id and survey_id
    response.choice_id = choice.id
    assert_equal(response.valid?, false)

    # Response has choice_id and question_id but not survey_id
    response.question_id = question.id
    assert_equal(response.valid?, false)

    # Response has choice_id, question_id and survey_id
    response.survey_id = survey.id
    assert_equal(response.valid?, true)
  end
end
