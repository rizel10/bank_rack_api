class User < Sequel::Model
  # Associations
	many_to_one :account
  one_to_many :operations

  # Validations
  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    validates_presence :account
    validates_presence :cpf
    validates_presence :pin
    validates_presence :name
    validates_presence :created_at
    validates_presence :updated_at
    validates_unique :cpf
    validates_unique :pin
    validates_format /\d{11}/, :cpf, message: 'is a digits only field'
  end

  def account_number
    account.account_number    
  end
  
end