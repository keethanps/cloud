require 'watir-webdriver' 
require 'test/unit'
include Test::Unit::Assertions
$webscreenshot_count = 0
$donefirstscenario=0
$indevice=0
#At subscription deletion API web page

When /^I login to cloud delete subscription api web page with '(.*)' and '(.*)'$/ do |username, password|
# Executing pre condition
begin
macro 'I signup'
macro 'I delete cloud picture'
puts ' executing precondition signup and delete cloud picture'
rescue Exception => e
puts ' executing precondition signup delete cloud picture'
end


$browser = Watir::Browser.new
url = 'https://'+username+':'+password+'@survey.vfnet.de/gigui/individuals/index'
$browser.goto url
Watir::Wait.until {$browser.text_field(:name => 'msisdn').exist?}
end

Then /^I delete the subscription for '(.*)'$/ do |msisdn|
$browser.text_field(:name => 'msisdn').set msisdn
$browser.button(:class => 'btn btn btn-danger').click
Watir::Wait.until {($browser.text.include? 'Deleted Entry with MSISDN')}
#||($browser.text.include? 'Could not delete')
end

def takewebscreenshot 
$screenshotname = "webscreenshot#{$webscreenshot_count}.png"
$browser.screenshot.save($screenshotname)
embed $screenshotname, 'image/png'
$webscreenshot_count += 1
end 

Then /^I take screen shot of web page$/ do
takewebscreenshot 
end





# cloud customer web page


class BrowserContainer

     def initialize(browser)
     $browser = browser
end
end

class Site < BrowserContainer

  def login_page
   @login_page = LoginPage.new($browser)
end

  def user_page
   @user_page = UserPage.new($browser)
   end

  def close
    $browser.close
end
end # Site

class LoginPage < BrowserContainer

 def open
  $browser.goto $URL
    self
end

  def login_as(user, pass)
    user_field.set user
    password_field.set pass
    login_button.click
sleep 3
    next_page = UserPage.new($browser)
    Watir::Wait.until { next_page.loaded? }
    next_page
  end

  def user_field
    $browser.text_field(:name => "username")
  end

  def password_field
   $browser.text_field(:type => "password")
  end

  def login_button
    $browser.button(:class => "buttonAubergine")
  end
end # LoginPage

class UserPage < BrowserContainer

  def logged_in?
  Watir::Wait.until {$browser.div(:id => 'paginationLeft').exist?}
  assert_equal($browser.span(:id => "menu-settings-account-name").exists? , true)
# next_page = Webscreenshottaker.new($browser)
  end

  def loaded?
    $browser.title == "Your Profile"
     next_page = UserPage.new($browser)
  end
end # UserPage


module SiteHelper
  def site
$webscreenshot_count ||= 0
    @site ||= (
      Site.new(Watir::Browser.new(:firefox))
    )
end
end


class Picturupload < BrowserContainer

def uploadpicture 
Watir::Wait.until { $browser.link(:id => 'upload').exists? }
$browser.link(:id => 'upload').click
next_page=Simpleupload.new($browser)
end
end

class Simpleupload < BrowserContainer

def simpleuploadpicture 
Watir::Wait.until { $browser.link(:id => 'showSimpleUpload').exists? }
$browser.link(:id => 'showSimpleUpload').click
next_page=Upload.new($browser)
end
end

class Upload < BrowserContainer

def uploadpicturefile(img)
#local_file='/home/keethan/Downloads/Buddha8.jpeg' 
#$Picturepath = '/home/muthu/Downloads/Buddha8.jpeg'
#$Picturename = 'Buddha8.jpeg'
Watir::Wait.until { $browser.file_field.exists? }
$browser.file_field(:multiple => 'true').set ENV["Picturepath"]
$browser.link(:id => 'html5UploadButton').click
Watir::Wait.until{$browser.link(:title => img).exist?}
end
end

class Picture < BrowserContainer

def openpicture(img3)
$browser.link(:title => img3).exist?
#$browser.link(:title => img3).click
#Watir::Wait.until{$browser.img(:id => 'media_file').exist?}
end
end


class Myfiles < BrowserContainer

def myfilesmenu(img1) 
Watir::Wait.until { $browser.link(:id => 'myfiles').exists? }
$browser.link(:id => 'myfiles').click
sleep 2
Watir::Wait.until{$browser.div(:class => 'thumbnail folderRow small_').exist?}
assert_equal($browser.text.include?(img1), false)
end
end




World(SiteHelper)


def findurl(opco)
case opco

when 'Germany'
$URL='https://cloud-pp.vodafone.de/'
else
puts "URL for OpCo  #{opco}  does not found"
end
end




Given /^I login to cloud '(.*)' server with '(.*)' as user and '(.*)' as password$/ do |opco, username,password|

# Executing pre condition
#begin
#macro 'I signup'
#puts ' executing precondition signup'
#rescue Exception => e
#puts ' executing precondition signup'
#end

findurl(opco)
   @login_page = site.login_page.open
   user_page = @login_page.login_as(username,password)
  user_page.logged_in?
   #site.close

end

Then /^I take a screenshot of the cloud server customer page$/ do
 takewebscreenshot
end

Then /^I upload '(.*)' picture to the cloud server$/ do |img|
picturupload=Picturupload.new($browser)
simpleupload=picturupload.uploadpicture
upload=simpleupload.simpleuploadpicture
upload.uploadpicturefile(img)
end

Then /^I should see the '(.*)' picture is uploaded in the cloud server$/ do |img3|
picture=Picture.new($browser)
picture.openpicture(img3)
end




Then /^I should not see '(.*)' picture in cloud server$/ do |img1|
myfiles = Myfiles.new($browser)
myfiles.myfilesmenu(img1)
end


Then /^I take a screenshot of the cloud server myfiles page$/ do
takewebscreenshot
$browser.close

end




Given /^there are no picture in cloud$/ do
begin
macro 'I signup'
macro 'I delete cloud picture'
puts ' executing precondition signup and delete cloud picture'
rescue Exception => e
puts ' executing precondition signup delete cloud picture'
end
end






# Android Client

Given /^I do not have any files in the device$/ do
#system 'adb -s $ADB_DEVICE_ARG shell  pm clear com.vodafone.cloud2'
begin
puts ' Executing precondition'
system 'adb -s $ADB_DEVICE_ARG shell pm clear com.vodafone.cloud2'
system ENV["remove"]
sleep 2
system 'adb -s $ADB_DEVICE_ARG reboot'
sleep 80
rescue Exception => e
puts ' Executing precondition'
end
end

Given /^cloud app is running on the device$/ do
#system 'adb kill-server'
#sleep 1
#system 'adb -s $ADB_DEVICE_ARG shell  am start -a android.intent.action.MAIN -n sh.calaba.android.test/sh.calaba.instrumentationbackend.WakeUp'

  $startTime = Time.now.to_f
  start_test_server_in_background
  $indevice=1
view='textview'
id ='textView_safe_storage_splashscreen_descr'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;startup|OOBE startup time for cloud app;time="+elapsedTime.to_s+"s"
else
        #macro 'I take a screenshot'
        puts 'Safe storage details view was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
end

Then /^I should see Safe storage and Automatic upload instruction and I  navigate to next page$/ do
performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
view='textview'
id ='textView_automatic_upload_splashscreen_descr'
if waittillviewisshown(view,id)
        performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
        performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
         $startTime = Time.now.to_f
else
        #macro 'I take a screenshot'
        puts 'Automatic upload details view was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
end

Then /^I sign up with '(.*)' as email address and '(.*)' as password$/ do |email,pass|
view='textview'
id='registration_userid_info'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;status|OOBE time for checking account status;time="+elapsedTime.to_s+"s"
   performAction('wait_for_view_by_id', 'registration_email_input')
   performAction('enter_text_into_id_field', email, 'registration_email_input')
      performAction('wait_for_view_by_id', 'registration_password_input')
      performAction('enter_text_into_id_field', pass, 'registration_password_input')
      performAction('wait_for_view_by_id', 'registration_password_repeat')
      performAction('enter_text_into_id_field', pass, 'registration_password_repeat')
            performAction('wait_for_view_by_id', 'registration_terms_and_conditions_checkbox')
      performAction('click_on_view_by_id','registration_terms_and_conditions_checkbox')
      performAction('wait_for_view_by_id', 'registration_signup_button')
      performAction('click_on_view_by_id','registration_signup_button')
      $startTime = Time.now.to_f
      
else
        #macro 'I take a screenshot'
        puts 'Account status was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
end


Then /^I should see content backup and how to backup settings$/ do
view='textview'
id = 'textview_backup_media_type_choices_descr'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
puts "KPI-For-Nagios: cloud;signup|OOBE signup time;time="+elapsedTime.to_s+"s"

else
       #macro 'I take a screenshot'
        puts 'Not able signup in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
end
performAction('wait_for_view_by_id', 'button_next_step')
performAction('click_on_view_by_id', 'button_next_step')
end


Then /^I proceed with the client to backup later$/ do
performAction('wait_for_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('click_on_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('wait_for_view_by_id', 'button_backup_later')
performAction('click_on_view_by_id', 'button_backup_later')
end



Then /^I am successfully login to cloud app with option to take a photo$/ do
view='textview'
$donefirstscenario=1
id='texts_hint_nophoto'
if waittillviewisshown(view,id)
performAction('wait_for_view_by_id', 'button_open_camera')
$browser.close
else
        #macro 'I take a screenshot'
        puts 'Cloud main page with take photo option was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
end
end


Given /^I do have picture in the device$/ do
#system 'adb -s $ADB_DEVICE_ARG shell pm clear com.vodafone.cloud2'
begin
puts ' Executing precondition'
system 'adb -s $ADB_DEVICE_ARG shell  pm clear com.vodafone.cloud2'
system ENV["push"]
sleep 2
system 'adb -s $ADB_DEVICE_ARG reboot'
sleep 80
rescue Exception => e
puts ' Executing precondition'
end
end


Then /^I am successfully login to cloud app with recently added items with backup now option$/ do 
view='gridview'
id='latestImages'
if waittillviewisshown(view,id)
$donefirstscenario=0
$browser.close

else
        #macro 'I take a screenshot'
        puts 'Cloud main page with recently added items was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
end
end


Then /^I should see login page of '(.*)'$/ do |msisdn|
view='textview'
id='login_userid_info'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;status|OOBE time for checking existing account status;time="+elapsedTime.to_s+"s"
else
        #macro 'I take a screenshot'
        puts 'Account status was not able to show up in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
 end
end



When /^I proceed with login$/ do
performAction('press_button_with_text', 'Log in')
$startTime = Time.now.to_f
end

Then /^I am successfully login to cloud app with last uploaded photos$/ do
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id)
else
        #macro 'I take a screenshot'
        puts 'Cloud main page with recently uploaded photos was not shown in time'
       performAction('exit_wait_for_view_by_id', 'expectedview')
        
        #exit
end
end

And /^I delete the cloud picture from the device$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')

count = 1
  
while (count <=10)
sleep 1

#puts (query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail')
if ((query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail') == true)
#assert_equal((query("textview id:'backup_status_text'").to_s.include? '1 photo'), true)
break
else
performAction('go_back')
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
count = count + 1
 if ((query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail') == false && count >= 10) then
        #macro 'I take a screenshot'
        puts 'Upload picture was not able to show up in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
    else end
    end
end

performAction('wait_for_view_by_id' , 'media_griditem_thumbnail')
performAction('click_on_view_by_id' , 'media_griditem_thumbnail')
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
performAction('select_from_menu', 'Delete')
performAction('wait_for_view_by_id' , 'delete_file_ok_button')
performAction('click_on_view_by_id' , 'delete_file_ok_button')

#performAction('wait_for_view_by_id' , 'delete_file_done_button')

view='button'
id='delete_file_done_button'
if waittillviewisshown(view,id)
performAction('click_on_view_by_id' , 'delete_file_done_button')
performAction('wait_for_view_by_id','menu_button')
Watir::Wait.until { $browser.link(:id => 'myfiles').exists? }
$browser.link(:id => 'myfiles').click
sleep 2
Watir::Wait.until{$browser.div(:class => 'thumbnail folderRow small_').exist?}
screenshot_embed
takewebscreenshot
$browser.close

else
        #macro 'I take a screenshot'
        puts 'Picture deletion was not done in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
end


Given /^I do have picture in the device and in cloud$/ do
begin
puts ' Executing precondition'
system 'adb -s $ADB_DEVICE_ARG shell pm clear com.vodafone.cloud2'
rescue Exception => e
puts ' Executing precondition'
end
end


Given /^cloud app is registered and running in the device$/ do
  $startTime = Time.now.to_f
  start_test_server_in_background
  $indevice=1
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;startup| startup time for cloud app;time="+elapsedTime.to_s+"s"
else
        #macro 'I take a screenshot'
        puts 'Cloud main page with recently uploaded photos was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end
end


Then /^I open the cloud photos menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
end

Then /^I should see the uploded '(.*)' picture$/ do |img|

count = 1
  
while (count <=10)
sleep 1

#puts (query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail')
if ((query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail') == true)
assert_equal((query("textview id:'backup_status_text'").to_s.include? '1 photo'), true)
break
else
performAction('go_back')
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
count = count + 1
 if ((query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail') == false && count >= 10) then
        #macro 'I take a screenshot'
        puts 'Upload picture was not able to show up in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
    else end
end
end
end

Then /^I open the uploaded picture$/ do
performAction('wait_for_view_by_id' , 'media_griditem_thumbnail')
performAction('click_on_view_by_id' , 'media_griditem_thumbnail')
#performAction('wait_for_view_by_id' , 'photos_view_pager')
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
end

And /^I delete the picture$/ do
performAction('select_from_menu', 'Delete')
performAction('wait_for_view_by_id' , 'delete_file_ok_button')
performAction('click_on_view_by_id' , 'delete_file_ok_button')
#performAction('wait_for_view_by_id' , 'delete_file_done_button')
view='button'
id='delete_file_done_button'
if waittillviewisshown(view,id)
performAction('click_on_view_by_id' , 'delete_file_done_button')
$deletedone = 1
performAction('wait_for_view_by_id','menu_button')
#assert_equal((query("imageview id:'media_griditem_thumbnail'").to_s.include? 'media_griditem_thumbnail'), false)
#assert_equal((query("textview id:'backup_status_text'").to_s.include? '0 photos'), true)


else
        #macro 'I take a screenshot'
        puts 'Picture deletion was not done in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
       # exit
        end
end






def waittillviewisshown(view,id)
count = 1  
while (count <=60)
queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query(queryparam).to_s.include? id) == true
return true
else
count = count + 1
 if ((query(queryparam).to_s.include? id) == false && count >= 60) then
return false
else end 
end
end
end





#needed when scenarion failed going to be executed via script in jenkins

def deletepicture
$browser = Watir::Browser.new
$browser.goto 'https://cloud-pp.vodafone.de/'
Watir::Wait.until { $browser.text_field(:name => "username").exists? }
$browser.text_field(:name => "username").set ENV["username"]
$browser.text_field(:type => "password").set ENV["password"]
$browser.button(:class => "buttonAubergine").click
Watir::Wait.until { $browser.link(:id => 'myfiles').exists? }
$browser.link(:id => 'myfiles').click
sleep 2
Watir::Wait.until{$browser.div(:class => 'thumbnail folderRow small_').exist?}
Watir::Wait.until{$browser.link(:title => ENV["picturename"]).exist?}
$browser.link(:title => ENV["picturename"]).right_click

Watir::Wait.until{$browser.link(:id => 'FileOptionsMenu_filemenu.delete').exist?}
$browser.link(:id => 'FileOptionsMenu_filemenu.delete').click

Watir::Wait.until{$browser.link(:id => 'confirmDeleteForever').exist?}
$browser.link(:id => 'confirmDeleteForever').click
sleep 3
Watir::Wait.until{$browser.div(:class => 'thumbnail folderRow small_').exist?}
takewebscreenshot
$browser.close
end


def deletemsisdn
@browser = Watir::Browser.new
url = 'https://cloud2x-testing:Eb6E322Du@survey.vfnet.de/gigui/individuals/index'
@browser.goto url
Watir::Wait.until {@browser.text_field(:name => 'msisdn').exist?}
@browser.text_field(:name => 'msisdn').set ENV["MSISDN"]
@browser.button(:class => 'btn btn btn-danger').click
Watir::Wait.until {@browser.text.include? 'Deleted Entry with MSISDN'}
@browser.close
end

# precondition signup or login in device
Then /^I signup$/ do
begin
system 'adb -s $ADB_DEVICE_ARG shell pm clear com.vodafone.cloud2'
  start_test_server_in_background
  $indevice=1
view='textview'
id ='textView_safe_storage_splashscreen_descr'
if waittillviewisshown(view,id)
else
        #macro 'I take a screenshot'
   #     puts 'Safe storage details view was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end

performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
view='textview'
id ='textView_automatic_upload_splashscreen_descr'
if waittillviewisshown(view,id)
        performAction('wait_for_view_by_id', 'buttonnext_safestorage_splashscreen')
        performAction('click_on_view_by_id', 'buttonnext_safestorage_splashscreen')
         $startTime = Time.now.to_f
else
        #macro 'I take a screenshot'
    #    puts 'Automatic upload details view was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end

view='textview'
id='registration_userid_info'
if waittillviewisshown(view,id)
   performAction('wait_for_view_by_id', 'registration_email_input')
   performAction('enter_text_into_id_field', ENV["username"], 'registration_email_input')
      performAction('wait_for_view_by_id', 'registration_password_input')
      performAction('enter_text_into_id_field', ENV["password"], 'registration_password_input')
      performAction('wait_for_view_by_id', 'registration_password_repeat')
      performAction('enter_text_into_id_field', ENV["password"], 'registration_password_repeat')
            performAction('wait_for_view_by_id', 'registration_terms_and_conditions_checkbox')
      performAction('click_on_view_by_id','registration_terms_and_conditions_checkbox')
      performAction('wait_for_view_by_id', 'registration_signup_button')
      performAction('click_on_view_by_id','registration_signup_button')
      
else
        #macro 'I take a screenshot'
     #   puts 'Account status was not able to show up in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
        end

view='textview'
id = 'textview_backup_media_type_choices_descr'
if waittillviewisshown(view,id)

else
       #macro 'I take a screenshot'
      #  puts 'Not able signup in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
#exit
end
performAction('wait_for_view_by_id', 'button_next_step')
performAction('click_on_view_by_id', 'button_next_step')

performAction('wait_for_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('click_on_view_by_id', 'radio_button_choice_turnoff_autobackup')

performAction('wait_for_view_by_id', 'button_backup_later')
performAction('click_on_view_by_id', 'button_backup_later')
shutdown_test_server

#view='textview'
#id='My Cloud'
#if waittillviewisshown(view,id)

#else
        #macro 'I take a screenshot'
 #       puts 'Cloud main page was not shown in time'
  #      performAction('exit_wait_for_view_by_id', 'expectedview')
        #exit
#end

rescue Exception => e
###### for login button
begin
view='textview'
id='login_userid_info'
if waittillviewisshown(view,id)
performAction('press_button_with_text', 'Log in')
else
       # puts 'Account status was not able to show up in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
end


view='textview'
id = 'textview_backup_media_type_choices_descr'
if waittillviewisshown(view,id)
else
#        puts 'Not able signup in time'
performAction('exit_wait_for_view_by_id', 'expectedview')
end

performAction('wait_for_view_by_id', 'button_next_step')
performAction('click_on_view_by_id', 'button_next_step')
performAction('wait_for_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('click_on_view_by_id', 'radio_button_choice_turnoff_autobackup')
performAction('wait_for_view_by_id', 'button_backup_later')
performAction('click_on_view_by_id', 'button_backup_later')
shutdown_test_server
rescue Exception => e
#puts 'running precondition'
end
end
end

Then /^I delete cloud picture$/ do
begin
deletepicture
rescue Exception => e
$browser.close
end
end
