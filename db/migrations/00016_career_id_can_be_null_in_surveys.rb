Sequel.migration do
  up do
  	alter_table(:surveys) do
	  set_column_not_null :career_id
	end
  end

  down do
    set_column_allow_null :career_id
  end
end
