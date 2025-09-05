
    class Avo::Resources::Category  < Avo::BaseResource
      self.model_class = ::Category  # Add this line
      self.title = :name
      self.includes = []
      self.search = {
        query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], slug_cont: params[:q], m: "or").result(distinct: false) }
      }

      def fields
        field :id, as: :id
        field :name, as: :text, required: true, placeholder: "Category name"
        field :slug, as: :text, required: true, placeholder: "category-slug"
        field :description, as: :textarea, rows: 4, placeholder: "Category description"
        field :active, as: :boolean
        field :blogs, as: :has_many
        field :created_at, as: :date_time, readonly: true
        field :updated_at, as: :date_time, readonly: true
      end

      def actions
        action Avo::Actions::ActivateCategory
        action Avo::Actions::DeactivateCategory
      end

      def filters
        filter Avo::Filters::ActiveCategoryFilter
      end
      # Actions, filters, grid view, etc. remain the same...
    end
