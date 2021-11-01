Sequel.migration do
  up do
    create_table(:scores) do
      primary_key :id
      foreign_key :career_id, :careers
      foreign_key :survey_id, :surveys
      DateTime :created_at, default: Sequel::CURRENT_TIMESTAMP
      # updated at DateTime will not be necesary, since we don't want scores to be modified
    end
  end

  down do
    drop_table(:scores)
  end
end
