require File.expand_path '../../test_helper.rb', __FILE__

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

  def test_choice_must_has_text
    # Arrange
    choice = Choice.new
    # Act
    choice.text = 'This is a text'
    # Assert
    assert_equal(choice.valid?, true)
  end

  #To implement
  def test_choice_has_many_responses
    # Arrange

    # Act

    # Assert

  end

end
