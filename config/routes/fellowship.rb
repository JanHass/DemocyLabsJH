resources :fellowships do
    member do
        get :join
        get :leave
        get :changeuserrole
        get :changetoadmin
        get :changetomod
        get :changetouser

        post "fellowships" => "fellowships#join"
        post "fellowships" => "fellowships#changeuserrole"


    end
      
end