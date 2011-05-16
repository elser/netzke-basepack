Feature: Tree panel
  In order to value
  As a role
  I want feature

@javascript
Scenario: Lazy loading of a folder tree nodes
  Given the following folders exist:
  | id               | name  | parent_id      |
  | 1                | Root  | nil            |
  | 2                | One   | 1              |
  | 3                | Two   | 1              |
  | 4                | Three | 3              |
  When I go to the FolderTree test page
  And I sleep 2 seconds
  When I expand node "Root"
  Then I should see "One"
  And I should see "Two"
  When I expand node "Two"
  Then I should see "Three"
  
@javascript
Scenario: Adding a node
  Given the following folders exist:
  | id               | name  | parent_id      |
  | 1                | Root  | nil            |
  | 2                | One   | 1              |
  When I go to the FolderTree test page
  When I expand node "Root"
  And I sleep 1 seconds
  And I expand menu of node "One"
  And I follow "Add"
  And I fill in "Name:" with "Maxim"
  And I press "OK"
  And I wait for the response from the server
  And I expand node "One"
  Then I should see "Maxim"
  And a folder should exist with parent_id: "2"

@javascript
Scenario: Editing a node
  Given the following folders exist:
  | id               | name  | parent_id      |
  | 1                | Root  | nil            |
  | 2                | One   | 1              |
  When I go to the FolderTree test page
  When I expand node "Root"
  And I sleep 1 seconds
  And I expand menu of node "One"
  And I follow "Edit"
  And I fill in "Name:" with "Maxim"
  And I press "OK"
  And I wait for the response from the server
  Then I should see "Maxim"
  And a folder should not exist with name: "One"

@javascript
Scenario: Deleting a node
  Given the following folders exist:
  | id               | name  | parent_id      |
  | 1                | Root  | nil            |
  | 2                | One   | 1              |
  When I go to the FolderTree test page
  When I expand node "Root"
  And I sleep 1 seconds
  And I expand menu of node "One"
  And I follow "Delete"
  And I press "Yes"
  And I wait for the response from the server
  Then I should not see "One"
  And a folder should not exist with name: "One"
