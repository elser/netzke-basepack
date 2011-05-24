class FolderTreeDragNDrop < Netzke::Basepack::BorderLayoutPanel
  config :items => [{
                   :class_name => "FolderTree",
                   :name => "folder_tree",
                   :region => :west,
                   :width => '50%',
                   :enable_d_d => true,
                   :dd_group => 'grid2tree',
                 },
                 {
                   :class_name => "BookGrid",
                   :name => "books",
                   :header => false,
                   :region => :center,
                   :enable_drag_drop => true,
                   :dd_group => 'grid2tree'
                 }
      ]

  
end
