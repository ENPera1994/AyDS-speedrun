Sequel.migration do
  up do
    alter_table(:surveys) do
      add_foreign_key :career_id, :careers, null: false
    end
  end

  down do
    drop_foreign_key :career_id, :careers
  end
end
