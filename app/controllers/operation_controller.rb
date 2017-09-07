class OperationController < BaseController

  def create
    operation = env["PATH_INFO"].split("/").last
    response.body = JSON[{ response: "Create #{operation} Operation for Account number: #{account_number} with ammount #{body["ammount"]}" }]
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