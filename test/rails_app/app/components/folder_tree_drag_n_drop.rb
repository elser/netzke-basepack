class FolderTreeDragNDrop < Netzke::Basepack::BorderLayoutPanel
  config :items => [{
                   :class_name => "FolderTree",
                   :name => "folder_tree",
                   :region => :west,
                   :width => '50%',
                 },
                 {
                   :class_name => "BookGrid",
                   :name => "books",
                   :header => false,
                   :region => :center
                 }
      ]

  
end
