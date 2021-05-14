Sequel.migration do
  up do
  	alter_table(:responses) do
	  add_foreign_key :choice_id, :choices, :null=>false
	end
  end

  down do
    drop_foreign_key :choice_id, :choices
  end
end
