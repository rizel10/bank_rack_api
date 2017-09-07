BankRackApplication.router.config do
  post /\/*accounts\/\d+\/operations\/deposit\/*/, :to => "operation#create"
  post /\/*accounts\/\d+\/operations\/withdraw\/*/, :to => "operation#create"
  get /\/*users\/\d+\/operations\/*/, :to => "operation#index"
end