class Upload < ApplicationRecord
  scope :by_most_recent, -> { order(created_at: :desc) }

  has_many :contacts, dependent: :destroy

  def self.most_recent
    order(created_at: :desc).first
  end

  def uploaded_at
    created_at.strftime("%a %b-%d")
  end
end
