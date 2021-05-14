Sequel.migration do
  up do
  	alter_table(:choices) do
	  add_foreign_key :question_id, :questions, :null=>false
	end
  end

  down do
    drop_foreign_key :question_id, :questions
  end
end
