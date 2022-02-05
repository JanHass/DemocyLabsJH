class Fellowship < ApplicationRecord
    has_one_attached :image   

    def locale
        self[:locale] ||= I18n.default_locale.to_s
      end

end
