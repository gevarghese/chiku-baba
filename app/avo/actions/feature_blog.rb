module Avo
  module Actions
    class FeatureBlog < Avo::BaseAction
      self.name = "Feature blog"
      self.standalone = true
     self.visible = -> { resource.record.nil? ? false : resource.record.featured? == false }

      def handle(models:, **)
        models.each do |model|
          model.update(featured: true)
        end

        succeed "Blogs featured successfully!"
      end
    end
  end
end
