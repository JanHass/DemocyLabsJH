class ProContra < ApplicationRecord
  validates :body, presence: true
  validates :tag, presence: true,
            length: { minimum: 2 , maximum: 50}
  validates :sources, presence: true


  belongs_to :user
  belongs_to :debate
  belongs_to :proposal
  belongs_to :poll
  belongs_to :vote
  belongs_to :fellowship
  has_many :objections, dependent: :destroy 


end
