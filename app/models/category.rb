class Category < ApplicationRecord
  include ImmutableSlug
  friendly_id :name, use: :slugged   # ✅ use :name, not :title

  has_many :blogs, dependent: :nullify
  
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  
  before_validation :generate_slug, if: -> { slug.blank? && name.present? }
  
  scope :active, -> { where(active: true) }
  scope :alphabetical, -> { order(name: :asc) }
  
  def to_param
    slug
  end
  
  private
  
  def generate_slug
    self.slug = name.parameterize
  end
end