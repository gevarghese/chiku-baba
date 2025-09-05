
    class Avo::Resources::Status < Avo::BaseResource
            self.model_class = ::Status  # Add this line
      self.title = :name
      self.includes = []
      self.search = {
        query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], slug_cont: params[:q], m: "or").result(distinct: false) }
      }

      def fields
        field :id, as: :id
        field :name, as: :text, required: true, placeholder: "Status name"
        field :slug, as: :text, required: true, placeholder: "status-slug"
        field :value, as: :number, required: true, placeholder: "Numeric value"
        field :description, as: :textarea, rows: 3, placeholder: "Status description"
        field :active, as: :boolean
        field :blogs, as: :has_many
        field :created_at, as: :date_time, readonly: true
        field :updated_at, as: :date_time, readonly: true
      end
      def actions
        action Avo::Actions::ActivateStatus
        action Avo::Actions::DeactivateStatus
      end

      def filters
        filter Avo::Filters::ActiveStatusFilter
      end
      # Actions, filters, grid view, etc. remain the same...
    end
