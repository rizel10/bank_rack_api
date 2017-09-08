class OperationPolicy

  def self.create?(current_user, object, custom={})
    if object.nil?
      return false
    end

    if custom[:operation_type] == "withdraw"
      return current_user.account == object
    else
      return true
    end
  end

  def self.index?(current_user, object, custom={})
    current_user == object
  end

end