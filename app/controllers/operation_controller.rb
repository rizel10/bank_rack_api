class OperationController < BaseController

  def create
    set_account
    operation_type = env["PATH_INFO"].split("/").last
    
    @operation = Operation.new
    params = { operation_type: operation_type, user: User.all.sample, account: @account, amount: body["amount"] }

    begin
      Account.db.transaction do
        @account.lock!
        @operation.update_fields(params, create_params, missing: :raise)
      end
    rescue Sequel::ValidationFailed => err
      response.body = JSON[{ errors: err.to_s, code: 101 }]
      response.status_code = 422
      return response
    end

    response.body = @operation.to_json
    response.status_code = 201
    return response
  end

  def index
    set_user
    response.body = query_results.to_json
    response.status_code = 200
    return response
  end

  private

    def create_params
      [:operation_type, :user, :account, :amount]      
    end

    def account_number
      return @account_number if @account_number
      return @account_number = env["PATH_INFO"].match(/\d+/).to_s.to_i # Type converted to integer so method is consistent with it's name.
    end

    def filter_params
      return @filter_params if @filter_params
      uri = Addressable::URI.new 
      uri.query = env["QUERY_STRING"]
      return @filter_params = uri.query_values.delete_if { |key, value| !(["created_after", "created_before"].include? key) }
    end

    # I'm used to Rails ActiveRecord, this is the first time I've used Sequel and
    # I failed to figure out how should I build a filtering method using Sequel
    # mostly because a Sequel::Model is a dataset, so I couldn't really add behaviour
    # to the class nor could I chain where clauses to build a full query (as I normally do on Rails).
    # I dislike this method below with all my heart, but at least it solves the problem... For now.
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

    def set_account
      @account = Account.first(account_number: account_number)      
    end

    def set_user
      @user = User.first(id: env["PATH_INFO"].match(/\d+/).to_s)      
    end

end