class Document < ApplicationRecord
  include Attachable

  has_attachment :attachment, url: "/system/:class/:prefix/:style/:hash.:extension",
                              hash_data: ":class/:style/:custom_hash_data",
                              use_timestamp: false,
                              hash_secret: Rails.application.secrets.secret_key_base

  belongs_to :user
  belongs_to :documentable, polymorphic: true, touch: true

  validates :title, presence: true
  validates :user_id, presence: true
  validates :documentable_id, presence: true,         if: -> { persisted? }
  validates :documentable_type, presence: true,       if: -> { persisted? }

  scope :admin, -> { where(admin: true) }

  Paperclip.interpolates :custom_hash_data do |attachment, _style|
    attachment.instance.custom_hash_data(attachment)
  end

  def self.humanized_accepted_content_types
    Setting.accepted_content_types_for("documents").join(", ")
  end

  def custom_hash_data(attachment)
    original_filename = if attachment.instance.persisted?
                          attachment.instance.title
                        else
                          attachment.instance.attachment_file_name
                        end
    "#{attachment.instance.user_id}/#{original_filename}"
  end

  def humanized_content_type
    attachment_content_type.split("/").last.upcase
  end

  def max_file_size
    documentable_class.max_file_size
  end

  def accepted_content_types
    documentable_class.accepted_content_types
  end

  private

    def association_name
      :documentable
    end

    def documentable_class
      association_class
    end
end
