{
    root: {text: 'Root', id: 'root'},
    loader: new Ext.tree.TreeLoader(),
		initComponent: function(params){
		this.loader.dataUrl = this.endpointUrl('get_children'); 
    Netzke.classes.Basepack.TreePanel.superclass.initComponent.call(this);
//    this.on('tabchange', function(self, i){
//      if (i && i.wrappedComponent && !i.items.first() && !i.beingLoaded) {
//        i.beingLoaded = true; // prevent more than one request per tab in case of fast clicking
//        this.loadComponent({name: i.wrappedComponent, container: i.id}, function(){i.beingLoaded = false});
//      }
//    }, this);
  }
}
