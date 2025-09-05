module Avo
  module Actions
    class ScheduleBlog < Avo::BaseAction
      self.name = "Schedule blog"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : (resource.record.published_at.nil? || resource.record.published_at > Time.current) }  # Add resource. and nil check

      def fields
        field :publish_time, as: :datetime, name: "Schedule for", default: -> { Time.current + 1.hour }
      end

      def handle(models:, fields:, **)
        scheduled_time = fields[:publish_time] || Time.current + 1.hour

        models.each do |model|
          model.update(
            published_at: scheduled_time,
            status: Status.find_by(slug: "scheduled") || Status.find_by(name: "scheduled")
          )
        end

        succeed "Blogs scheduled for #{scheduled_time.strftime('%B %d, %Y at %H:%M')}!"
      end
    end
  end
end
