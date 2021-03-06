Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      foreign_key :account_id, unique: true, null: false
      String :name, null:false
      String :cpf, unique: true, null: false
      String :encrypted_pin, unique: true, null: false
      String :encrypted_auth_token, unique: true
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end
