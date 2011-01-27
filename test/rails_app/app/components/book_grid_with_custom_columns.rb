class BookGridWithCustomColumns < Netzke::Basepack::GridPanel
  js_property :title, "Books"

  def default_config
    super.merge(
      :model => "Book",
      :columns => [
        {:name => :author__first_name, :locked => true},
        {:name => :author__last_name, :renderer => :uppercase},
        :author__name,
        :title,
        :digitized,
        {
          :name => :rating,
          :editor => {
            :trigger_action => :all,
            :xtype => :combo,
            :store => [[1, "Good"], [2, "Average"], [3, "Poor"]]
          },
          :renderer => "function(v){return ['', 'Good', 'Average', 'Poor'][v];}"
        },
        :exemplars,
        :updated_at
      ]
    )
  end

end
