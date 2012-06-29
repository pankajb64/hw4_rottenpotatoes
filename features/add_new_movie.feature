Feature: Add A New Movie

  As a Developer/User
  So that I can see and use the information of the added movie.
  I want to add a new movie to  RottenPotatoes
  
Scenario: Add new movie to the list
  Given I am on the RottenPotatoes home page
  When I follow "Add new movie"
  And I fill in "Title" with "Home Alone"
  And I fill in "Director" with "Richard Hadlee"
  And I press "Save Changes"
  Then I should be on the RottenPotatoes home page
  And I should see "Home Alone was successfully created."
  
