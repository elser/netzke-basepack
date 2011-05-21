class BookGrid < Netzke::Basepack::GridPanel

  js_property :title, "Books"

  def default_config
    super.merge(
      :model => "Book",
      :sort_info => { :sort=> :title, :dir => :desc },
      :persistence => true
    )
  end
end
