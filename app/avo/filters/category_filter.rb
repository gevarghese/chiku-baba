module Avo
  module Filters
    class CategoryFilter < Avo::Filters::SelectFilter
      self.name = "Category"

      def apply(request, query, value)
        return query if value.blank?

        query.where(category_id: value)
      end

      def options
        Category.active.order(name: :asc).each_with_object({}) do |category, options|
          options[category.id] = category.name
        end
      end
    end
  end
end