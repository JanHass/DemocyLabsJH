resource :account, controller: "account", only: [:show, :update, :delete] do
  get :erase, on: :collection
  delete :purgeavatar
end
