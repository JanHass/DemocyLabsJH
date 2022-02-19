class Fellowship < ApplicationRecord

    include Rails.application.routes.url_helpers
    include Taggable

    belongs_to :owner, class_name: 'User'

    has_one_attached :image

    has_many :fellowship_users, :dependent => :destroy
    has_many :members, through: :fellowship_users, source: :user

      def locale
        self[:locale] ||= I18n.default_locale.to_s
      end

end
