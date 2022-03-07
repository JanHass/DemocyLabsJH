class FellowshipUser < ApplicationRecord

    validates :user_id, :presence => true 
    validates :fellowship_id, :presence => true	
   
    validates :user_id, :uniqueness => {:scope => [:user_id, :fellowship_id]}

    belongs_to :user
    belongs_to :fellowship

  
    
end
