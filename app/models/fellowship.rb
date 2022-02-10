class Fellowship < ApplicationRecord
    has_one_attached :image
    include PgSearch

    pg_search_scope :search_full_text, against: :name, :using => {
        :tsearch => {:prefix => true},
        :trigram => {}
      }

end
