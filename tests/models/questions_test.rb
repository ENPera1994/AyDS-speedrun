require File.expand_path '../../test_helper.rb', __FILE__

class QuestionTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase

  def test_question_must_has_name
    # Arrange
    question1 = Question.new(name: '')
    question2 = Question.new(name: nil)
    question3 = Question.new(name: 'I am a question?')
    # Act


    # Assert
    assert_equal(question1.valid?, false)
    assert_equal(question2.valid?, false)
  end

end
