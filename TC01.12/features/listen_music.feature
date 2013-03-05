Feature: Listen uploaded music in the device

  Scenario: Listen uploaded music in the device
    Given cloud app is running on the device
    When I open cloud music menu
    Then I see the uploaded music in list view
    Then I take a screenshot
    When I open one of the music
    Then I can see the music is opened by the audio player
    Then I take a screenshot
    Then I listen to the full music
    When the music is fully played
    Then I see the music menu again
    Then I take a screenshot
