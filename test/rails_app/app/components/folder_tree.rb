class FolderTree < Netzke::Basepack::TreePanel
  config :split => true,
    :auto_scroll => :true,
    :root_visible => true,
    :indicate_leafs => true,
    :model => "Folder"
end
