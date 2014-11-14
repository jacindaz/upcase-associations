class GuestbookEntry < ActiveRecord::Base
  validates :body,
    format: { message: "contains a bad word", without: /silly/i },
    length: { maximum: 255 },
    presence: true

  scope :limited, -> { limit(5) }
  scope :most_recent_first, -> { order("created_at DESC") }
  scope :most_recent_limited, -> { limited.most_recent_first.recent }
  scope :recent, -> { where(["created_at >= ?", 30.days.ago]) }
end
