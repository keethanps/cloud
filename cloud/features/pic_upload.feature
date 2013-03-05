Feature: Picture upload via web

@web
Scenario: Upload file from PC to cloud Server
Given there are no picture in cloud
Given I login to cloud 'Germany' server with 'aiosamy16@gmail.com' as user and 'Keethan12' as password
Then I take a screenshot of the cloud server customer page
Then I upload 'Buddha8.jpeg' picture to the cloud server
Then I should see the 'Buddha8.jpeg' picture is uploaded in the cloud server
Then I take a screenshot of the cloud server customer page

@client
Scenario: Open cloud app and check the uploaded picture
Given cloud app is registered and running in the device
Then I open the cloud photos menu
Then I should see the uploded 'Buddha8.jpeg' picture
Then I take a screenshot
Then I open the uploaded picture 
Then I take a screenshot
And I delete the picture
Then I take a screenshot

@web
Scenario: Check the picture is deleted in the cloud server
Then I should not see 'Buddha8.jpeg' picture in cloud server
Then I take a screenshot of the cloud server myfiles page
