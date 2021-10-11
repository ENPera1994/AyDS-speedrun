require File.expand_path '../../test_helper.rb', __FILE__

class ScoreTest < MiniTest::Unit::TestCase
    MiniTest::Unit::TestCase

    def test_score_has_a_career
        
        career = Career.create(name: 'Lic in tests')
        score = Score.create(career_id: career.id)
        
        assert_equal(score.valid?, false)
    end

    def test_score_has_a_survey
        
        career = Career.create(name: 'Lic in tests')
        survey = Survey.create(username: 'Test')
        score = Score.crate(survey_id: survey.id)

        assert_equal(score.valid?, false) 
    end

    def test_score_has_a_survey_and_career
        
        career = Career.create(name: 'Lic in tests')
        survey = Survey.create(username: 'Test')
        score = Score.crate(career_id: career.id, survey_id: survey.id)

        assert_equal(score.valid?, true) 
    end