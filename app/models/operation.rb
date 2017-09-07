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

  # Filtering methods
  # def self.filtering_chain(filtering_params)
  #   results = self.all
  #   filtering_params.each do |key, value|
  #     association = results.public_send(key, value)
  #     results = association
  #   end
  #   results
  # end

  # def self.created_after(date)
  #   self.where{ created_at > date.to_date << 1 }
  # end

  # def self.created_before(date)
  #   self.where{ created_at < date.to_date << 1 }
  # end

end