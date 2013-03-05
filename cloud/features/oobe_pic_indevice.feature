Feature: Cloud OOBE and with picture in device and not in cloud

@web
Scenario: Delete Subscription for an existing user
When I login to cloud delete subscription api web page with 'cloud2x-testing' and 'Eb6E322Du'
Then I delete the subscription for '491740451517'
Then I take screen shot of web page

@client
Scenario: Cloud client first launch for a new user with pictures in device and not in cloud
Given I do have picture in the device
Given cloud app is running on the device
Then I take a screenshot
Then I should see Safe storage and Automatic upload instruction and I  navigate to next page
Then I sign up with 'aiosamy16@gmail.com' as email address and 'Keethan12' as password
Then I should see content backup and how to backup settings
Then I take a screenshot
Then I proceed with the client to backup later
Then I am successfully login to cloud app with recently added items with backup now option
Then I take a screenshot
