resources :fellowships do
    member do
        get :join
        get :leave
        get :changeuserrole
        post "fellowships" => "fellowships#join"
        post "fellowships" => "fellowships#changeuserrole"

    end
      
end