module Avo
  module Actions
    class DeactivateCategory < Avo::BaseAction
      self.name = "Deactivate category"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : resource.record.active? }  # Change to resource.record with nil check

      def handle(models:, **)
        models.each do |model|
          model.update(active: false)
        end

        succeed "Categories deactivated successfully!"
      end
    end
  end
end
