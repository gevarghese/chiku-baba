# app/models/concerns/immutable_slug.rb
module ImmutableSlug
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
  end

  # Only generate slug when blank (immutable)
  def should_generate_new_friendly_id?
    slug.blank?
  end
end
