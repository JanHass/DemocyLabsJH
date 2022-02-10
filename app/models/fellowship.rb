class Fellowship < ApplicationRecord
    include Rails.application.routes.url_helpers
    include Taggable
    
    has_one_attached :image
    has_many :fellowship_users, :dependent => :destroy
    has_many :users, through: :fellowship_users


end
