module Avo
  module Filters
    class PublishedFilter < Avo::Filters::BooleanFilter
      self.name = "Published status"

      def apply(request, query, values)
        return query if values.blank?

        query = query.where(published_at: nil) if values['draft']
        query = query.where.not(published_at: nil) if values['published']
        query
      end

      def options
        {
          draft: "Draft",
          published: "Published"
        }
      end
    end
  end
end