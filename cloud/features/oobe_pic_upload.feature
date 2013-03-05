Feature: TC01.03, 01.04, 01.05, 01.06 Cloud OOBE and picture upload

@web
Scenario: Delete Subscription for an existing user
When I login to cloud delete subscription api web page with 'cloud2x-testing' and 'Eb6E322Du'
Then I delete the subscription for '491740451517'
Then I take screen shot of web page

@client
Scenario: Cloud client first launch for a new user with no pictures in device and cloud
Given I do not have any files in the device
Given cloud app is running on the device
Then I take a screenshot
Then I should see Safe storage and Automatic upload instruction and I  navigate to next page
Then I sign up with 'aiosamy16@gmail.com' as email address and 'Keethan12' as password
Then I should see content backup and how to backup settings
Then I take a screenshot
Then I proceed with the client to backup later
Then I am successfully login to cloud app with option to take a photo
Then I take a screenshot

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

@web
Scenario: Upload file from PC to cloud Server
Given I login to cloud 'Germany' server with 'aiosamy16@gmail.com' as user and 'Keethan12' as password
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
Then I should see login page of '491740451517' 
Then I take a screenshot
When I proceed with login
Then I should see content backup and how to backup settings
Then I take a screenshot
Then I proceed with the client to backup later
Then I am successfully login to cloud app with last uploaded photos
Then I take a screenshot
And I delete the cloud picture from the device

@web
Scenario: Upload file from PC to cloud Server
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
