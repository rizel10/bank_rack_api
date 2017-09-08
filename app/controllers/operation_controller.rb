class OperationController < BaseController

  def create
    # authenticate user
    unless authenticate_user
      return response
    end

    # set the account where the operation is being made
    set_account
    # set the operation type from request url 
    operation_type = env["PATH_INFO"].split("/").last

    # authorize request
    unless OperationPolicy.create?(@current_user, @account, { operation_type: operation_type })
      response.error(104, "You can't do a #{operation_type} on account #{account_number}")
      return response
    end
    
    # Build operation object
    @operation = Operation.new
    params = { operation_type: operation_type, user: @current_user, account: @account, amount: body["amount"] }

    # ensure database consistency by locking account and using one transaction
    begin
      Account.db.transaction do
        @account.lock!
        @operation.update_fields(params, create_params, missing: :raise)
      end
    rescue Sequel::ValidationFailed => err
      response.error(101, err.to_s)
      return response
    end

    # success response
    response.body = @operation.serialize
    response.status_code = 201
    return response
  end

  def index
    # authenticate user
    unless authenticate_user
      return response
    end

    # set the user where the operations will be listed
    set_user

    # authorize request
    unless OperationPolicy.create?(@current_user, @account, { operation_type: operation_type })
      response.error(104, "Can't list other users operations")
      return response
    end

    # success response
    response.body = query_results.to_json(except: [:id, :updated_at, :user_id, :account_id])
    response.status_code = 200
    return response
  end

  private

    # required params to insert an operation
    def create_params
      [:operation_type, :user, :account, :amount]      
    end

    # account_number getter
    def account_number
      return @account_number if @account_number
      return @account_number = env["PATH_INFO"].match(/\d+/).to_s.to_i # Type converted to integer so method is consistent with it's name.
    end

    # permitted filter_params
    def permitted_filter_params
      ["created_after", "created_before"]
    end

    # set and filter permitted filter_params
    def filter_params
      return @filter_params if @filter_params
      uri = Addressable::URI.new 
      uri.query = env["QUERY_STRING"]
      return @filter_params = uri.query_values.delete_if { |key, value| !(permitted_filter_params.include? key) }
    end

    # I'm used to Rails ActiveRecord, this is the first time I've used Sequel and
    # I failed to figure out how should I build a filtering method using Sequel
    # mostly because a Sequel::Model is a dataset, so I couldn't really add behaviour
    # to the class nor could I chain where clauses to build a full query (as I normally do on Rails).
    # I dislike this method below with all my heart, but at least it solved the problem... For now.
    def query_results
      u_id = @user.id
      f_crtd_after = filter_params["created_after"] if filter_params.has_key? "created_after"
      f_crtd_before = filter_params["created_before"] if filter_params.has_key? "created_before"
      if filter_params.keys.count == 2
        Operation.where{ (user_id=~ u_id) & (created_at > f_crtd_after) & (created_at < f_crtd_before) }.all
      elsif f_crtd_after
        Operation.where{ (user_id=~ u_id) & (created_at > f_crtd_after) }.all
      elsif f_crtd_before
        Operation.where{ (user_id=~ u_id) & (created_at < f_crtd_before) }.all
      end
    end

    # @account setter
    def set_account
      @account = Account.first(account_number: account_number)      
    end

    # @user setter
    def set_user
      @user = User.first(id: env["PATH_INFO"].match(/\d+/).to_s)      
    end

end