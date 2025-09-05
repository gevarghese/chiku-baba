class Status < ApplicationRecord
  has_many :blogs
  
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true, uniqueness: true
  validates :value, presence: true, uniqueness: true
  
  before_validation :generate_slug, if: -> { slug.blank? && name.present? }
  
  # Class methods for easy access - ONLY HERE
  def self.draft
    find_by(slug: 'draft')
  end
  
  def self.published
    find_by(slug: 'published')
  end
  
  def self.archived
    find_by(slug: 'archived')
  end

  
  def self.draft_id
    @draft_id ||= draft&.id
  end
  
  def self.published_id
    @published_id ||= published&.id
  end
  
  def self.archived_id
    @archived_id ||= archived&.id
  end  
  private
  
  def generate_slug
    self.slug = name.parameterize
  end
end