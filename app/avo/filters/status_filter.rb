module Avo
  module Filters
    class StatusFilter < Avo::Filters::SelectFilter
      self.name = "Status"

      def apply(request, query, value)
        return query if value.blank?

        query.where(status_id: value)
      end

      def options
        Status.active.order(name: :asc).each_with_object({}) do |status, options|
          options[status.id] = status.name
        end
      end
    end
  end
end