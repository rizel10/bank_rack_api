class Operation < Sequel::Model
	many_to_one :user

  plugin :enum
  enum :operation_type, [:deposit, :withdraw]

  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    validates_presence :user_id
    validates_presence :operation_type
    validates_presence :amount
    validates_include [0, 1], :operation_type
  end
end