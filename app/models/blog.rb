class Blog < ApplicationRecord
  include ImmutableSlug
  friendly_id :title, use: :slugged
  has_one_attached :featured_image
  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  
  # Define status as an enum
  enum :status, { draft: 0, published: 1, archived: 2 }, default: :draft
  
  validates :title, presence: true
  validates :content, presence: true
  validates :slug, presence: true, uniqueness: true
  
  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  
  scope :published, -> { 
  where(status: :published)
  .where('published_at IS NOT NULL AND published_at <= ?', Time.current) 
   }
  scope :draft, -> { where(status: :draft) }
  scope :archived, -> { where(status: :archived) }
  scope :recent, -> { order(published_at: :desc) }
  scope :featured, -> { where(featured: true) }
  
  def published?
    status == 'published' && published_at.present? && published_at <= Time.current
  end
  
  def draft?
    status == 'draft'
  end
  
  def archived?
    status == 'archived'
  end
  
  def reading_time
    words_per_minute = 200
    text = ActionController::Base.helpers.strip_tags(content.to_s)
    (text.split.size.to_f / words_per_minute).ceil
  end
  
  def root_comments
    comments.root_comments.recent
  end
  
  private
  
  def generate_slug
    self.slug = title.parameterize
  end
end