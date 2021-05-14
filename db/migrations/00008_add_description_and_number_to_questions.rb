Sequel.migration do
  up do
    add_column :questions, :description, String
    add_column :questions, :number, Integer
  end

  down do
    drop_column :questions, :description
    drop_column :questions, :number
  end
end