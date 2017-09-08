class Account < Sequel::Model
  # Associations
	one_to_one :user
  one_to_many :operations

  # Validations
  plugin :validation_helpers # Shipped in with Sequel!
  def validate
    super
    # validates_presence :user # don't know how this would work on Sequel
    validates_unique :account_number
    validates_presence :current_balance
    validates_presence :created_at
    validates_presence :updated_at
  end

  def current_balance
    super.to_f
  end

  def serialize
    self.to_json(except: [:id, :created_at, :updated_at])
  end
end