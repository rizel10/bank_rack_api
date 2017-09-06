Sequel.migration do
  change do
    create_table :operations do
      primary_key :id
      foreign_key :user_id, :users
      Integer :operation_type, null: false
      BigDecimal :amount, size: [13, 2], null: false
    end
  end
end