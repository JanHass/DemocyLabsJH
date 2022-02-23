resources :fellowships do
    member do
        get :join
        get :leave
        get :changeuserrole
        get :tablesort

        post "fellowships" => "fellowships#join"
        post "fellowships" => "fellowships#changeuserrole"
        get :kick


    end
      
end