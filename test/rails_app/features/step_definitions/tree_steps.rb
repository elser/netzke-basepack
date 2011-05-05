When /^I expand node "([^"]*)"$/ do |arg1|
  page.driver.browser.execute_script <<-JS
    var components = [];
    for (var cmp in Netzke.page) { components.push(cmp); }
    var tree = Netzke.page[components[0]];
    for (var member in tree.nodeHash){
      var node = Netzke.page.folderTree.nodeHash[member]; 
      if(node.text == '#{arg1}') {
        node.expand();
      } 
    }
  JS
end
