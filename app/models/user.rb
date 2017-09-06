class User < Sequel::Model
	many_to_one :account, key: :account_number
  one_to_many :operations

  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    validates_presence :account_number
    validates_presence :cpf
    validates_presence :pin
    validates_presence :name
    validates_unique :cpf
    validates_unique :pin
    validates_format /\d{11}/, :cpf, message: 'is a digits only field'
  end
end