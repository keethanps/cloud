Feature: Cloud OOBE and with picture in device and in cloud

@web
Scenario: Upload file from PC to cloud Server
Given I login to cloud 'Germany' server with '<email>' as user and '<pass>' as password
Then I take a screenshot of the cloud server customer page
Then I upload 'Buddha8.jpeg' picture to the cloud server
Then I should see the 'Buddha8.jpeg' picture is uploaded in the cloud server
Then I take a screenshot of the cloud server customer page

@client
Scenario: Cloud Client first launch for an existing user with picture in device and cloud
Given I do have picture in the device and in cloud
Given cloud app is running on the device
Then I take a screenshot
Then I should see Safe storage and Automatic upload instruction and I  navigate to next page
Then I should see login page of '<number>' 
Then I take a screenshot
When I proceed with login
Then I should see content backup and how to backup settings
Then I take a screenshot
Then I proceed with the client to backup later
Then I am successfully login to cloud app with last uploaded photos
Then I take a screenshot
And I delete the cloud picture from the device
