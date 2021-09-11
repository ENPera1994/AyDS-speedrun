  
require File.expand_path '../../test_helper.rb', __FILE__

class ResponseTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase  

  def test_response_must_has_survey
    
    # Arrange
    survey = Survey.new
    response = Response.new    

    # Act
    response.survey_id = survey.id

    # Assert
    assert_equal(response.valid?, false)
  end

    def test_response_must_has_question
    
    # Arrange
    question = Question.new
    response = Response.new    

    # Act
    response.question_id = question.id 

    # Assert
    assert_equal(response.valid?, false)
  end
   
  def test_response_must_has_choice
    
    # Arrange
    choice = Choice.new
    response = Response.new    

    # Act
    response.choice_id = choice.id 

    # Assert
    assert_equal(response.valid?, false)
  end

end