Feature: Cloud OOBE and no picture in device and in cloud

@web
Scenario: Delete Subscription for an existing user
When I login to cloud delete subscription api web page with 'cloud2x-testing' and 'Eb6E322Du'
Then I delete the subscription for '<number>'
Then I take screen shot of web page

@client
Scenario: Cloud client first launch for a new user with no pictures in device and cloud
Given I do not have any files in the device
Given cloud app is running on the device
Then I take a screenshot
Then I should see Safe storage and Automatic upload instruction and I  navigate to next page
Then I sign up with '<email>' as email address and '<pass>' as password
Then I should see content backup and how to backup settings
Then I take a screenshot
Then I proceed with the client to backup later
Then I am successfully login to cloud app with option to take a photo
Then I take a screenshot
