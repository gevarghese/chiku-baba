module Avo
  module Actions
    class UnpublishBlog < Avo::BaseAction
      self.name = "Unpublish blog"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : resource.record.published_at.present? }

      def handle(models:, **)
        models.each do |model|
          model.update(
            published_at: nil,
            status: Status.find_by(slug: "draft") || Status.find_by(name: "draft")
          )
        end

        succeed "Blogs unpublished successfully!"
      end
    end
  end
end
