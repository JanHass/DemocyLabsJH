class AdminNotification < ApplicationRecord
  include Notifiable

  translates :title, touch: true
  translates :body,  touch: true
  include Globalizable

  validates_translation :title, presence: true
  validates_translation :body, presence: true
  validates :segment_recipient, presence: true
  validate :validate_segment_recipient

  before_validation :complete_link_url

  def list_of_recipients
    UserSegments.send(segment_recipient) if valid_segment_recipient?
  end

  def valid_segment_recipient?
    segment_recipient && UserSegments.respond_to?(segment_recipient)
  end

  def draft?
    sent_at.nil?
  end

  def list_of_recipients_count
    list_of_recipients&.count || 0
  end

  def deliver
    list_of_recipients.each { |user| Notification.add(user, self) }
    update!(sent_at: Time.current, recipients_count: list_of_recipients.count)
  end

  private

    def validate_segment_recipient
      errors.add(:segment_recipient, :invalid) unless valid_segment_recipient?
    end

    def complete_link_url
      return unless link.present?

      unless link =~ /\A(http:\/\/|https:\/\/|\/)/
        self.link = "http://#{link}"
      end
    end
end
