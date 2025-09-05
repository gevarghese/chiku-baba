class Avo::Resources::Blog < Avo::BaseResource
self.model_class = ::Blog
      self.title = :title
      self.includes = [ :category, :user, :status ]
      self.search = {
        query: -> { query.ransack(id_eq: params[:q], title_cont: params[:q], slug_cont: params[:q], m: "or").result(distinct: false) }
      }

      def fields
        field :id, as: :id
        field :title, as: :text, required: true, placeholder: "Enter blog title"
        field :slug, as: :text, required: true, placeholder: "blog-url-slug", readonly: -> { !record.new_record? }

        # Content field using Action Text
        field :content, as: :trix, attachment_key: :attachments, always_show: false

        # Image attachments
        field :featured_image, as: :file, is_image: true, accept: "image/*", help: "Main blog image"
        field :avatar, as: :file, is_image: true, accept: "image/*", help: "Author avatar or secondary image"

        # Relationships
        field :category, as: :belongs_to, required: false
        field :user, as: :belongs_to, default: -> { current_user.id }, readonly: true
        field :status, as: :belongs_to, required: true

        # Date and boolean fields
        field :published_at, as: :datetime, time_24hr: true, help: "Schedule publication date"
        field :featured, as: :boolean, help: "Feature this blog on homepage"

        # Readonly fields
        field :view_count, as: :number, readonly: true, format_using: -> { value.to_i.to_s }
        field :created_at, as: :date_time, readonly: true
        field :updated_at, as: :date_time, readonly: true

        # Computed fields with nil checks
        field :reading_time, as: :text, only_on: :show do |model|
          model.nil? ? "Unknown" : "#{model.reading_time} min read"
        end

        field :publication_status, as: :badge, only_on: :index do |model|
          if model.nil?
            "Unknown"
          elsif model.published? && model.published_at <= Time.current
            "Published"
          elsif model.published_at.present? && model.published_at > Time.current
            "Scheduled"
          else
            "Draft"
          end
        end

        # Has many relationships with nil checks
        field :comments, as: :has_many, hide_on: :all
        field :active_comments, as: :has_many, only_on: :show do |model|
          model.nil? ? [] : model.comments.approved
        end
      end

      def actions
        # Actions with proper resource.record references and nil checks
        action Avo::Actions::PublishBlog
        action Avo::Actions::ScheduleBlog
        action Avo::Actions::UnpublishBlog
        action Avo::Actions::FeatureBlog
        action Avo::Actions::UnfeatureBlog
        action Avo::Actions::GenerateSlug
      end

      def filters
        # Filters (make sure they exist or remove them)
        filter Avo::Filters::PublishedFilter
        filter Avo::Filters::FeaturedFilter
        filter Avo::Filters::StatusFilter
        filter Avo::Filters::CategoryFilter
        filter Avo::Filters::ScheduledFilter
      end

      def grid
        # Grid view
        cover :featured_image, as: :file, is_image: true, link_to_resource: true
        title :title, as: :text, link_to_resource: true
        body :slug, as: :text
        body :category, as: :belongs_to
        body :publication_status, as: :badge, options: {
          success: [ "Published" ],
          warning: [ "Scheduled" ],
          danger: [ "Draft", "Unknown" ]
        }
      end

      def sidebars
        # Sidebar with nil checks
        sidebar do
          field :featured_image, as: :file, is_image: true
          field :title, as: :text
          field :slug, as: :text
          field :status, as: :badge, options: {
            success: [ "published", "active" ],
            danger: [ "draft", "inactive" ],
            warning: [ "scheduled", "pending" ]
          }
          field :featured, as: :boolean
          field :view_count, as: :number
          field :published_at, as: :date_time
          field :reading_time, as: :text do |model|
            model.nil? ? "Unknown" : "#{model.reading_time} min read"
          end
        end
      end
end
