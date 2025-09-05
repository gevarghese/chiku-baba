class Comment < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  
  validates :body, presence: true
  
  scope :root_comments, -> { where(parent_id: nil) }
  scope :recent, -> { order(created_at: :desc) }
  
  def root?
    parent_id.nil?
  end
  
  def reply?
    !root?
  end
  
  def has_replies?
    replies.exists?
  end
end