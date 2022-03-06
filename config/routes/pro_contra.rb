resources :pro_contras do
    member do
        delete :destroy_objection
    end

    resources :objections
end