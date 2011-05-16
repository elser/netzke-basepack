module Netzke
  module Basepack
    class TreePanel < Netzke::Base
      class NodeEditorForm < FormPanel
        def configuration
          super.tap do |s|
          end
        end
      end
    end
  end
end