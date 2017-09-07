class User < Sequel::Model
  include BCrypt
  attr_reader :pin
  attr_reader :auth_token

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
    validates_unique :encrypted_pin
    validates_unique :encrypted_auth_token
    validates_format /\d{11}/, :cpf, message: 'is a digits only field'
  end

  def account_number
    account.account_number    
  end

  def pin
    @pin ||= Password.new(encrypted_pin)
  end

  def pin=(new_pin)
    @pin = Password.create(new_pin)
    self.encrypted_pin = @pin
  end

  def auth_token
    @auth_token ||= Password.new(encrypted_auth_token)
  end

  def auth_token=(new_auth_token)
    @auth_token = Password.create(new_auth_token)
    self.encrypted_auth_token = @auth_token
  end
  
end