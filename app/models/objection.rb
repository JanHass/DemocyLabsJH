class Objection < ApplicationRecord
  validates :body, presence: true
  validates :sources, presence: true
  
  
  belongs_to :user
  belongs_to :pro_contra
end
