module Avo
  module Filters
    class ScheduledFilter < Avo::Filters::SelectFilter
      self.name = "Publication status"

      def apply(request, query, value)
        return query if value.blank?

        case value
        when 'published'
          query.where('published_at IS NOT NULL AND published_at <= ?', Time.current)
        when 'scheduled'
          query.where('published_at > ?', Time.current)
        when 'draft'
          query.where(published_at: nil)
        else
          query
        end
      end

      def options
        {
          'published': 'Published',
          'scheduled': 'Scheduled',
          'draft': 'Draft'
        }
      end
    end
  end
end