class Fellowship < ApplicationRecord

    has_one_attached :image
    has_many :fellowship_users, :dependent => :destroy
    has_many :users, through: :fellowship_users

    validates :name, presence: true
    validates :email, presence: true

      def locale
        self[:locale] ||= I18n.default_locale.to_s
      end

end
