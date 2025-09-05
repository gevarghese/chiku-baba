module Avo
  module Filters
    class FeaturedFilter < Avo::Filters::BooleanFilter
      self.name = "Featured status"

      def apply(request, query, values)
        return query if values.blank?

        query = query.where(featured: true) if values['featured']
        query = query.where(featured: false) if values['not_featured']
        query
      end

      def options
        {
          featured: "Featured",
          not_featured: "Not Featured"
        }
      end
    end
  end
end