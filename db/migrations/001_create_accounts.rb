Sequel.migration do
  change do
    create_table :accounts do
      Integer :account_number, primary_key: true
      BigDecimal :current_balance, size: [13, 2], null: false, default: 0
    end
  end
end