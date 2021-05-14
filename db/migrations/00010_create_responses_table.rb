Sequel.migration do
  up do
    create_table(:responses) do
      primary_key   :id
      foreign_key   :survey_id,   :surveys
      foreign_key   :question_id,   :questions
      DateTime      :created_at,   default: Sequel::CURRENT_TIMESTAMP
      DateTime      :updated_at,   default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:responses)
  end
end
