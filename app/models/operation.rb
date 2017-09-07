class Operation < Sequel::Model
  # Associations
	many_to_one :user
  many_to_one :account
  
  # Enum array
  def self.operation_types
    [:deposit, :withdraw]
  end

  # Enumerators
  plugin :enum
  enum :operation_type, self.operation_types

  # Validations
  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    validates_presence :user
    validates_presence :account
    validates_presence :operation_type
    validates_presence :amount
    validates_presence :created_at
    validates_presence :updated_at
    validates_includes Operation.operation_types, :operation_type
  end

  # Hooks
  def after_create
    math_symbols = { deposit: "+", withdraw: "-" }
    self.account.update(current_balance: self.account.current_balance.send(math_symbols[self.operation_type], self.amount))
    super
  end

end