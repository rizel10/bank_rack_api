class User < Sequel::Model
	many_to_one :account, key: :account_number
  one_to_many :operations
end