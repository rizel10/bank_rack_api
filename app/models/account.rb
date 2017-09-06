class Account < Sequel::Model
	one_to_one :user, key: :account_number

  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    # validates_presence :user # don't know how this would work on Sequel
    validates_unique :account_number
    validates_presence :current_balance
  end
end