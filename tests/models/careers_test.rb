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
    assert_equal(career.surveys.count, 2) 
  end
end