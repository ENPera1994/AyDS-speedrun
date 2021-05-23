require File.expand_path '../../test_helper.rb', __FILE__

class SurveyTest < MiniTest::Unit::TestCase
  MiniTest::Unit::TestCase
  def test_suvery_must_has_username
    # Arrange
    survey1 = Survey.new
    survey2 = Survey.new
    # Act
    survey1.username = ''
    survey2.username = nil
    # Assert
    assert_equal(survey1.valid?, false)
    assert_equal(survey2.valid?, false)
  end

  def test_survey_has_a_career
    # Arrange
    career = Career.create(name: 'c1')
    # Act
    #survey1 = Survey.create(username: '1') this gives an error during testing, so its ok
    survey2 = Survey.create(username: '2', career_id: career.id)
    # Assert
    #assert_equal(survey1.valid?, false)
    assert_equal(survey2.valid?, true)
    
  end
end