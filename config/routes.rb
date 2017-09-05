BankRackApplication.router.config do
  post /\/*accounts\/\d+\/operations\/deposit\/*/, :to => "operation#create"
  post /\/*accounts\/\d+\/operations\/withdraw\/*/, :to => "operation#create"
  get /\/*accounts\/\d+\/operations\/*/, :to => "operation#index"
end