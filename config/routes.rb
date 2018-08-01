Rails.application.routes.draw do
  api_version(module: "V1", path: { value: "v1" }, defaults: { format: :json }) do
  	resource :advertisers do
  		post :create_wallet
      post :get_tokens
      post :approve_tokens
  		patch :update_wallet
      get :get_balance
  	end
  	resource :owners do
  		post :create_wallet
      post :get_tokens
      post :approve_tokens
  		patch :update_wallet
      get :get_balance
  	end
  end
end
