class Account < Sequel::Model
	one_to_one :user, key: :account_number
end