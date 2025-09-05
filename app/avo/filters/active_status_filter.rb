module Avo
  module Filters
    class ActiveStatusFilter < Avo::Filters::BooleanFilter
      self.name = "Active status"

      def apply(request, query, values)
        return query if values.blank?

        query = query.where(active: true) if values['active']
        query = query.where(active: false) if values['inactive']
        query
      end

      def options
        {
          active: "Active",
          inactive: "Inactive"
        }
      end
    end
  end
end