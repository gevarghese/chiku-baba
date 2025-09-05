module Avo
  module Actions
    class GenerateSlug < Avo::BaseAction
      self.name = "Generate slug"
      self.standalone = true
     self.visible = -> { resource.record.nil? ? false : (resource.record.title.present? && resource.record.slug.blank?) } # Change to record

      def handle(models:, **)
        models.each do |model|
          model.update(slug: model.title.parameterize) if model.title.present?
        end

        succeed "Slugs generated successfully!"
      end
    end
  end
end
