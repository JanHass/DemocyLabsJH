resources :fellowships do
    member do
        get :join
        get :leave
        post "fellowships" => "fellowships#join"
    end
      
end