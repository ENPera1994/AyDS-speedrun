require File.expand_path '../../test_helper.rb', __FILE__

class ScoreTest < MiniTest::Unit::TestCase
    MiniTest::Unit::TestCase

    def test_score_has_a_survey_and_career

        career = Career.create(name: 'Lic in tests')
        survey = Survey.create(username: 'Test')
        score = Score.create(career_id: career.id, survey_id: survey.id)

        assert_equal(score.valid?, true) 
    end
end