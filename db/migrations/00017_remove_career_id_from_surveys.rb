Sequel.migration do
  up do
    alter_table(:surveys) do
      drop_foreign_key :career_id
    end
  end

  down do
    add_foreign_key :career_id, :careers, :null=>false
  end
end