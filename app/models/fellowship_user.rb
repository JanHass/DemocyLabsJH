class FellowshipUser < ApplicationRecord
    
    include Rails.application.routes.url_helpers
    include Taggable

    

    belongs_to :user
    belongs_to :fellowship

  
    
end
