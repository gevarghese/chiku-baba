module Avo
  module Actions
    class DeactivateStatus < Avo::BaseAction
      self.name = "Deactivate status"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : resource.record.active? }  # Change to resource.record with nil check

      def handle(models:, **)
        models.each do |model|
          model.update(active: false)
        end

        succeed "Statuses deactivated successfully!"
      end
    end
  end
end
