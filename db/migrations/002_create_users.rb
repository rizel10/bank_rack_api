Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      foreign_key :account_number, :accounts, type: 'integer', unique: true, null: false
      String :name, null:false
      String :cpf, unique: true, null: false
      String :pin, unique: true, null: false
    end
  end
end
