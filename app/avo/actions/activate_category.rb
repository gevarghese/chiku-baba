module Avo
  module Actions
    class ActivateCategory < Avo::BaseAction
      self.name = "Activate category"
      self.standalone = true
      self.visible = -> { resource.record.nil? ? false : resource.record.active? == false }  # Change to resource.record with nil check

      def handle(models:, **)
        models.each do |model|
          model.update(active: true)
        end

        succeed "Categories activated successfully!"
      end
    end
  end
end
