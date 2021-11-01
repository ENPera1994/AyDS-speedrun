Sequel.migration do
  up do
    create_table(:posts) do
      primary_key   :id
      String        :description
      #    DateTime      :created_at,   default: Sequel::CURRENT_TIMESTAMP
      #    DateTime      :updated_at,   default: Sequel::CURRENT_TIMESTAMP
    end
  end

  down do
    drop_table(:posts)
  end
end
