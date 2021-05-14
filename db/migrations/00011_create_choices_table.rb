Sequel.migration do
  up do
    create_table(:choices) do
      primary_key   :id
      String        :text
      DateTime      :created_at,   default: Sequel::CURRENT_TIMESTAMP
      DateTime      :updated_at,   default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:choices)
  end
end
