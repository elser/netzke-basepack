require "netzke/basepack/grid_panel/columns"

module Netzke
  module Basepack
    class TreePanel < Netzke::Base
      js_base_class "Ext.tree.TreePanel"
      js_mixin :tree_panel
      include Netzke::Basepack::DataAccessor
      include Netzke::Basepack::GridPanel::Columns

      js_translate *%w[are_you_sure confirmation]

      def default_config
        super.tap {|c|
          c[:indicate_leafs] = true
          c[:auto_scroll] = true
          c[:root_visible] = true
        }
      end

      def js_config #:nodoc:
        super.merge({
          :context_menu => config.has_key?(:context_menu) ? config[:context_menu] : default_context_menu,
          :model => config[:model], # the model name
          :pri => data_class.primary_key # table primary key name
        })
      end

      # Override to change the default context menu
      def default_context_menu
        res = %w{ add edit del }.map(&:to_sym).map(&:action)
        res
      end

      action :add do
        {
          :text => I18n.t('netzke.basepack.tree_panel.actions.add'),
          :tooltip => I18n.t('netzke.basepack.tree_panel.actions.add'),
          :icon => :add
        }
      end

      action :edit do
        {
          :text => I18n.t('netzke.basepack.tree_panel.actions.edit'),
          :tooltip => I18n.t('netzke.basepack.tree_panel.actions.edit'),
          :icon => :table_edit
        }
      end

      action :del do
        {
          :text => I18n.t('netzke.basepack.tree_panel.actions.del'),
          :tooltip => I18n.t('netzke.basepack.tree_panel.actions.del'),
          :icon => :table_row_delete
        }
      end

      component :node_editor do
        {
          :lazy_loading => true,
          :class_name => "Netzke::Basepack::TreePanel::NodeEditorWindow",
          :title => "Add #{data_class.model_name.human}",
          :button_align => "right",
          :items => [{
            :class_name => "Netzke::Basepack::TreePanel::NodeEditorForm",
            :model => config[:model],
            :items => default_fields_for_forms,
            :persistent_config => config[:persistent_config],
            :border => true,
            :bbar => false,
            :header => false,
            :mode => config[:mode]
          }.deep_merge(config[:node_form_config] || {})]
        }.deep_merge(config[:node_form_window_config] || {})
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
        if node
          node.children.map do |n| 
            {
              :text => n.name, 
              :id => n.id, 
              :leaf => config[:indicate_leafs] && n.children.empty?,
              :adding_children_enabled => true
            }
          end
        else
          []
        end
      end
      
      endpoint :node_selected do |params|
        # override this method if needed
      end
      
      endpoint :node_received_drag_and_drop do |params| #nodeReceivedDragAndDrop
        # override this method if needed
        puts "paramsssssssss " + params.inspect
      end
      
      endpoint :delete_node do |params|
        data_class.delete(params[:id])
      end
      
      # When providing the edit_form component, fill in the form with the requested record
      def deliver_component_endpoint(params)
        if params[:name] == 'node_editor'
          form = components[:node_editor][:items].first
          if(!form[:record])
            form.merge!(:record => params[:record_id] ? data_class.find(params[:record_id]) : data_class.new)
          end
          form[:record].parent_id = params[:parent_id].to_i if params[:parent_id] && params[:parent_id].to_i>0
        end
        super
      end
      
    end
  end
end
