class Post < ApplicationRecord
  belongs_to :author
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :author, allow_destroy: true

  delegate :name, to: :author, prefix: true

  validates :author, presence: true
  validates :title, presence: true

  def self.recent(limit)
    Post.order('posted_at DESC').limit(limit)
  end

  def slug
    "#{self.title} #{self.posted_at.strftime('%F')}".downcase.parameterize
  end
end
