module Avo
  module Actions
    class UnfeatureBlog < Avo::BaseAction
      self.name = "Unfeature blog"
      self.standalone = true
     self.visible = -> { resource.record.nil? ? false : resource.record.featured? }

      def handle(models:, **)
        models.each do |model|
          model.update(featured: false)
        end

        succeed "Blogs unfeatured successfully!"
      end
    end
  end
end
