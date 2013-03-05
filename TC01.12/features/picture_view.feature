Feature: TC0.12 View uploaded pictures in the device

  Scenario: View uploaded pictures in the device
    Given cloud app is running on the device
    When I open cloud picture menu
    Then I see the uploaded pictures in grid view
    Then I take a screenshot
    When I open one of the pictures
    Then I can see the pictures are opened in the image viewer
    Then I take a screenshot
    Then I swipe right to see the next picture
    Then I take a screenshot
    When I touch the opened picture
    Then I see the contextual menu
    Then I take a screenshot
    #Then I can zoom in 
    #Then I take a screenshot
    #Then I can zoon out
    #Then I take a screenshot
    Then I go back and see the pictures in grid view
    Then I take a screenshot

