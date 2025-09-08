class Blog < ApplicationRecord
  include ImmutableSlug
  friendly_id :title, use: :slugged
  has_one_attached :featured_image
  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  # This is the correct way to validate Action Text content
  has_rich_text :content
  validates :content, presence: true
    # Add this line for avatar attachment
  has_one_attached :avatar
  
  belongs_to :status
  validates :status, presence: true
  # Scopes - use the class methods from Status model

  scope :published, -> { 
    where(status_id: Status.published_id)
    .where('published_at IS NOT NULL AND published_at <= ?', Time.current) 
  }

  scope :draft, -> { where(status_id: Status.draft_id) }
  scope :archived, -> { where(status_id: Status.archived_id) }
  scope :recent, -> { order(published_at: :desc) }
  scope :featured, -> { where(featured: true) }

  # Combined scopes (examples)
  scope :featured_published, -> { featured.published }
  scope :recent_published, -> { published.recent }
  scope :featured_recent, -> { featured.published.recent }

  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: { on: :create }
  
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  

  
  def published?
    status&.slug == 'published' && published_at.present? && published_at <= Time.current
  end
  
  def draft?
    status&.slug == 'draft'
  end
  
  def archived?
    status&.slug == 'archived'
  end
  
  def reading_time
    words_per_minute = 200
    text = ActionController::Base.helpers.strip_tags(content.to_s)
    (text.split.size.to_f / words_per_minute).ceil
  end
  
  def root_comments
    comments.root_comments.recent
  end
  
# For Avo compatibility with friendly_id
  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
  

  private
  
  def generate_slug
    self.slug = title.parameterize
  end
end
