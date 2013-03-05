Feature: View uploaded video in the device

  Scenario: View uploaded video in the device
    Given cloud app is running on the device
    When I open cloud video menu
    Then I see the uploaded videos in grid view
    Then I take a screenshot
    When I open one of the videos
    Then I can see the video is opened by the media player
    Then I take a screenshot
    Then I watch the full video
    When the video is finished
    Then I see the video menu again
    Then I take a screenshot
