class Operation < Sequel::Model
  # Associations
	many_to_one :user
  
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
    validates_presence :user_id
    validates_presence :operation_type
    validates_presence :amount
    validates_presence :created_at
    validates_presence :updated_at
    validates_includes Operation.operation_types, :operation_type
  end


end