BankRackApplication.router.config do
  post /\/*accounts\/\d+\/operations\/deposit\/*/, :to => "operation#create"
  post /\/*accounts\/\d+\/operations\/withdraw\/*/, :to => "operation#create"
  get /\/*users\/\d+\/operations\/*/, :to => "operation#index"
  post "/users/auth/sign_in", :to => "token#create"
  delete "/users/auth/sign_out", :to => "token#destroy"
end