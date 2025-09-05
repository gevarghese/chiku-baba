module Avo
  module Actions
    class ActivateStatus < Avo::BaseAction
      self.name = "Activate status"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : resource.record.active? == false }  # Change to resource.record with nil check

      def handle(models:, **)
        models.each do |model|
          model.update(active: true)
        end

        succeed "Statuses activated successfully!"
      end
    end
  end
end
