module Netzke
  module Basepack
    class TreePanel < Netzke::Base
      js_base_class "Ext.tree.TreePanel"
      js_mixin :tree_panel
      include Netzke::Basepack::DataAccessor

      def default_config
        super.tap {|c|
          c[:indicate_leafs] = true
          c[:auto_scroll] = true
          c[:root_visible] = true
        }
      end

      # Returns something like:      
      #     [
      #      { 'id'=> 1, 'text'=> 'A folder Node', 'leaf'=> false },
      #      { 'id'=> 2, 'text'=> 'A leaf Node', 'leaf'=> true }
      #     ]
      endpoint :get_children do |params|
        if params[:node] == 'root'
          node = data_class.find_by_parent_id(nil) || data_class.find_by_parent_id(0)
        else
          node = data_class.find(params[:node])
        end
        node.children.map do |n| 
          {
            :text => n.name, 
            :id => n.id, 
            :leaf => config[:indicate_leafs] && n.children.empty? 
          }
        end
      end
      
    end
  end
end
