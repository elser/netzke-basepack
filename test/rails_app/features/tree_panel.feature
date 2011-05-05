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
