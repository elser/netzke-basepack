{
  root: {text: 'Root', id: 'root'},
  loader: new Ext.tree.TreeLoader(),
	initComponent: function(params) {
	  this.loader.dataUrl = this.endpointUrl('get_children'); 
    Netzke.classes.Basepack.TreePanel.superclass.initComponent.call(this);
    if (this.contextMenu) {
      this.on('contextmenu', this.onContextMenu, this);
      this.on('containercontextmenu', this.onContextMenu, this);
    }
    this.on('click', function(e){
      this.nodeSelected({node: e.id});
    }, this);
    this.on('beforenodedrop', this.onReceiveDragAndDrop, this);
		this.on('nodedragover', function(dragOverEvent){
			// do not invite users to drop teasers, lists or items in between nodes
			// FIXME: user has to drag over text exactly. if we disable this function, then the user still has to drag over text exactly,
			//        except if they are not on exact text it goes in between nodes. so this issue occurs no matter.
			//        this does not seem to be an issue with our css (i disabled ours and tested).
			    var isDraggedTeaserListOrItem = dragOverEvent.data.selections; // if it's from the grid, it's a list, teaser or digital item
			    var isDragAboveOrBelow = dragOverEvent.point != "append"; // it is above or below the node
			
			        if(isDraggedTeaserListOrItem && isDragAboveOrBelow) {
			            return false;
			        }
			});
  },
	
  onContextMenu: function(node){
		if(node.root) { // in case of right-click outside the tree
			node = node.root;
		}
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
    }
    node.select();
    menu.node = node;
    menu.show(node.ui.getEl());
  },
	
	onAdd: function(event) {
		node = event.ownerCt.node;
    this.loadComponent({
      name: 'node_editor', 
      params: {parent_id: node.id},
      callback: function(win){
        win.on('close', function(){
          if (win.closeRes === "ok") {
						if(node.parentNode) {
              node.parentNode.reload();
						} else {
              node.reload();
						}
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
            event.ownerCt.node.parentNode.reload();
          }
        }, this);
        win.show();
			}, 
			scope: this
		});
  },

  onDel: function(event) {
      Ext.Msg.confirm(this.i18n.confirmation, this.i18n.areYouSure, function(btn){
        if (btn == 'yes') {
          this.deleteNode({id: event.ownerCt.node.id}, function(){
            event.ownerCt.node.parentNode.reload();
          }, this);
        }
      }, this);
    },
  
	onReceiveDragAndDrop: function(e) {
      // e.data.selections is the array of selected records
      if(Ext.isArray(e.data.selections)) {
          // reset cancel flag
          e.cancel = false;
          // setup dropNode (it can be array of nodes)
          //e.dropNode = [];
          for(var i = 0; i < e.data.selections.length; i++) {
              // get record from selectons
              var r = e.data.selections[i];
              this.nodeReceivedDragAndDrop({node: e.target.id, draggable: r.id});
          }
          // we don't want Ext to complete the drop, thus return false
          return true;
      }
      // if we get here the drop is automatically cancelled by Ext
    },
}
