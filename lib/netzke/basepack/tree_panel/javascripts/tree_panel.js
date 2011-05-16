{
  root: {text: 'Root', id: 'root'},
  loader: new Ext.tree.TreeLoader(),
	initComponent: function(params) {
	  this.loader.dataUrl = this.endpointUrl('get_children'); 
    Netzke.classes.Basepack.TreePanel.superclass.initComponent.call(this);
		var _this = this;
    function onItemClick(item) {
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
    if (this.contextMenu) {
      this.on('contextmenu', this.onContextMenu, this);
    }

     this.on('click', function(e){
        alert('click ' + e.id);
           //this.selectTreeNode({filter: e.attributes.filter});
      }, this);
  },
	
  onContextMenu: function(node){
    var menu = new Ext.menu.Menu({
      items: this.contextMenu
    });
    if(node.attributes.addingChildrenEnabled) {
//      editItem.enable();
//      deleteItem.enable();
//      if(node.id=='root') {
//        deleteItem.disable();
//        editItem.disable();
//      }
      node.select();
//      var menuC = new Ext.menu.Menu({ id: 'mainContext', items: [
//              { id: 'new_folder',text: 'Nowy', handler: onItemClick }
//              ]
//      });
//      var editItem = new Ext.menu.Item({ id: 'edit_folder',text: 'Edytuj', handler: onItemClick })
//      var deleteItem = new Ext.menu.Item({ id: 'delete_folder',text: 'Usuń', handler: onItemClick })
//      menuC.addItem(editItem);
//      menuC.addItem(deleteItem);
      menu.node = node;
      menu.show(node.ui.getEl());
    }
  },
	
	onAdd: function(event) {
    this.loadComponent({
      name: 'node_editor', 
      params: {parent_id: event.ownerCt.node.id},
      callback: function(win){
        win.on('close', function(){
          if (win.closeRes === "ok") {
            this.getRootNode().reload(null);
          }
        }, this);
        win.show();
      }, 
      scope: this
    });
	},
	
  onEdit: function(event){
    this.loadComponent({
			name: 'node_editor', 
      params: {record_id: event.ownerCt.node.id},
		  callback: function(win){
        win.on('close', function(){
          if (win.closeRes === "ok") {
            this.getRootNode().reload(null);
          }
        }, this);
        win.show();
			}, 
			scope: this
		});
  },
}
