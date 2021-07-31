class Link < ApplicationRecord
  ALLOWED_SCHEMES = %w(
    http
    https
  ).freeze
  
  has_many :hits

  validates_presence_of :url

  before_validation :strip_whitespace
  def strip_whitespace
    self.url&.strip!
  end

  validate :valid_url?
  def valid_url?
    # URL validation can be improved to check TLDs.
    begin
      if URI.regexp(ALLOWED_SCHEMES).match(self.url) && !URI.parse(self.url).host.blank?
        return true
      end
    rescue URI::InvalidURIError
    end
    self.errors.add(:url, "is invalid")
  end

  after_validation :assign_token
  def assign_token
    self.token = generate_token
  end

  private

  def generate_token
    # For privacy reasons, we generate random tokens, even if it's for the same URL
    # Bit.ly does this as well. Multiple people can request same URL to be shortened,
    # and /:token/info should show visits for each short link separately.
    token = SecureRandom.alphanumeric(8)
    while Link.check_collision(token)
      token = SecureRandom.alphanumeric(8)
    end
    token
  end

  def self.check_collision token
    self.where(token: token).exists?
  end
end
