module Avo
  module Actions
    class PublishBlog < Avo::BaseAction
      self.name = "Publish blog"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : (resource.record.published_at.nil? || resource.record.published_at > Time.current) }  # Add nil check

      def handle(models:, **)
        models.each do |model|
          model.update(
            published_at: Time.current,
            status: Status.find_by(slug: "published") || Status.find_by(name: "published")
          )
        end

        succeed "Blogs published successfully!"
      end
    end
  end
end
