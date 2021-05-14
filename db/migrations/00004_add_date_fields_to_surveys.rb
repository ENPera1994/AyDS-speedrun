Sequel.migration do
  up do
  	alter_table(:surveys) do
	  add_foreign_key :career_id, :carreers, :null=>false
	end
  end

  down do
    drop_foreign_key :career_id, :carreers
  end
end
