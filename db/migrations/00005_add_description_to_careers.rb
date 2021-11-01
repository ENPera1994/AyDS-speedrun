Sequel.migration do
  up do
    add_column :careers, :description, String
  end

  down do
    drop_column :careers, :description
  end
end
