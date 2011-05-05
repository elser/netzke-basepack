module Netzke
  module Basepack
    class TreePanel < Netzke::Base
      js_base_class "Ext.tree.TreePanel"
      js_mixin :tree_panel
      
      endpoint :get_children do |params|
        puts params.inspect
#        [
#         { 'id'=> 1, 'text'=> 'A folder Node', 'leaf'=> false },
#         { 'id'=> 2, 'text'=> 'A leaf Node', 'leaf'=> true }
#        ]
        klass = config[:model].constantize
        node = params[:node] == 'root' ? klass.find_by_parent_id(nil) : klass.find(params[:node].to_i)
        puts node.inspect
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
