Sequel.migration do
  change do
    create_table :accounts do
      primary_key :id
      Integer :account_number, null: false, unique: true
      BigDecimal :current_balance, size: [13, 2], null: false, default: 0
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end