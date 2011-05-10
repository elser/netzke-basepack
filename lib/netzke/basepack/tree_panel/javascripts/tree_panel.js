{
  root: {text: 'Root', id: 'root'},
  loader: new Ext.tree.TreeLoader(),
	initComponent: function(params){
	  this.loader.dataUrl = this.endpointUrl('get_children'); 
    Netzke.classes.Basepack.TreePanel.superclass.initComponent.call(this);
		var _this = this;
      function onItemClick(item) {
        var parameter = menuC.node.id;
        var win = new Ext.Window({
	        title: "Folder",
	        modal: true,
	        width: 400,
	        height: 150,
	        layout: 'fit',
	        closeAction: 'destroy'
        });

       switch (item.id) {
            case 'new_folder':
              win.show(true, function() {
                _this.loadComponent({
                name: "email_folder",
                params: {parent: parameter},
                container: win.id
                });
              }, this);

            break;

            case 'edit_folder':
              win.show(true, function()
              {
                _this.loadComponent({
                name: "email_folder",
                params: {record_id: parameter},
                container: win.id
                });
              }, this);
            break;

              case 'delete_folder':
                _this.deleteFolder({folder: parameter});
            break;
        }
      }

      if(menuC==null)
      {
        var menuC = new Ext.menu.Menu({ id: 'mainContext', items: [
          '<h1>Folder</h1>',
                { id: 'new_folder',text: 'Nowy', handler: onItemClick }

                ]
        });
        var editItem = new Ext.menu.Item({ id: 'edit_folder',text: 'Edytuj', handler: onItemClick })
         var deleteItem = new Ext.menu.Item({ id: 'delete_folder',text: 'Usuń', handler: onItemClick })
        menuC.addItem(editItem);
        menuC.addItem(deleteItem);
      }
      this.on('contextmenu', function(node) {
        if(node.attributes.addingChildrenEnabled) {
          editItem.enable();
          deleteItem.enable();
          if(node.id=='root')
          {
            deleteItem.disable();
            editItem.disable();
          }
          node.select();
          menuC.node = node
          menuC.show(node.ui.getEl());
        }
      });

       this.on('click', function(e){
          alert('click ' + e.id);
             //this.selectTreeNode({filter: e.attributes.filter});
        }, this);
  }
}
