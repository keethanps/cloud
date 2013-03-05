#require 'watir-webdriver' 
require 'test/unit'
include Test::Unit::Assertions

Given /^cloud app is running on the device$/ do
view='gridview'
id='latest_items_preview'
if waittillviewisshown(view,id)
elapsedTime = Time.now.to_f - $startTime
   puts "KPI-For-Nagios: cloud;startup|OOBE startup time for cloud app;time="+elapsedTime.to_s+"s"
else
       
        puts 'Cloud main page with recently uploaded photos was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end


When /^I open cloud picture menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_photos')
performAction('click_on_view_by_id','sliding_menu_item_photos')
end

Then /^I see the uploaded pictures in grid view$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud picture menus was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the pictures$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud picture menus was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_griditem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_griditem_thumbnail')
end

Then /^I can see the pictures are opened in the image viewer$/ do
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
#performAction('click_on_view_by_id','media_griditem_thumbnail'
end

Then /^I swipe right to see the next picture$/ do 
performAction('wait_for_view_by_id','photos_view_pager_item_imageview')
performAction('swipe','right')
end

When /^I touch the opened picture$/ do
performAction('wait_for_view_by_id','photos_view_pager')
performAction('click_on_view_by_id','photos_view_pager')
end

Then /^I see the contextual menu$/ do
#performAction('wait_for_view_by_id','photos_view_pager')
#performAction('click_on_view_by_id','photos_view_pager')
#performAction('press_menu')
end

Then /^I can zoom in$/ do
performAction("doubletouch_coordinate", 315.5,363.5)
#performAction('click_on_view_by_id','photos_view_pager')
end 

Then /^I can zoon out$/ do
performAction("doubletouch_coordinate", 315.5,363.5)
#performAction('click_on_view_by_id','photos_view_pager')
end

Then /^I go back and see the pictures in grid view$/ do
performAction('go_back')
performAction('go_back')
#sleep 4
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud picture menus was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end

performAction('wait_for_view_by_id','media_griditem_thumbnail')
end



When /^I open cloud video menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_videos')
performAction('click_on_view_by_id','sliding_menu_item_videos')
end

Then /^I see the uploaded videos in grid view$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud video menu was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the videos$/ do
system 'adb -s $ADB_DEVICE_ARG logcat -b events -c' # clearing the logs
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud videos list were not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_griditem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_griditem_thumbnail')
end

Then /^I can see the video is opened by the media player$/ do
count = 1
value =""
while  (value == "")
value=`adb -s $ADB_DEVICE_ARG logcat -b events -d | grep android.intent.action.VIEW`
sleep(1.0/5.0)
if count == 100
puts 'Media player was not opened in time'
   performAction('exit_wait_for_view_by_id', 'expectedview')
else
count = count + 1
end 
end
sleep 15
end


Then /^I watch the full video$/ do
count = 1  
while (count <=3000)
#queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query("imageview").to_s.include? 'media_griditem_thumbnail') == true
break
else
count = count + 1
end
end
end

When /^the video is finished$/ do
end

Then /^I see the video menu again$/ do
view='imageview'
id='media_griditem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud video menu was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end


When /^I open cloud music menu$/ do
performAction('wait_for_view_by_id','menu_button')
performAction('click_on_view_by_id','menu_button')
performAction('wait_for_view_by_id','sliding_menu_item_music')
performAction('click_on_view_by_id','sliding_menu_item_music')
end

Then /^I see the uploaded music in list view$/ do
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music menu was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

When /^I open one of the music$/ do
system 'adb -s $ADB_DEVICE_ARG logcat -b events -c' # clearing the logs
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music list was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
performAction('wait_for_view_by_id','media_listitem_thumbnail')
sleep 2
performAction('click_on_view_by_id','media_listitem_thumbnail')
end

Then /^I can see the music is opened by the audio player$/ do
count = 1
value =""
while  (value == "")
value=`adb -s $ADB_DEVICE_ARG logcat -b events -d | grep android.intent.action.VIEW`
sleep(1.0/5.0)
if count == 100
puts 'Music player was not opened in time'
   performAction('exit_wait_for_view_by_id', 'expectedview')
else
count = count + 1
end 
end
sleep 15
end

Then /^I listen to the full music$/ do
count = 1  
while (count <=3000)
#queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query("imageview").to_s.include? 'media_listitem_thumbnail') == true
break
else
count = count + 1
end
end
end

When /^the music is fully played$/ do
end


Then /^I see the music menu again$/ do
view='imageview'
id='media_listitem_thumbnail'
if waittillviewisshown(view,id)
else
       
        puts 'Cloud music menu was not shown in time'
        performAction('exit_wait_for_view_by_id', 'expectedview')
        end
end

def waittillviewisshown(view,id)
count = 1  
while (count <=100)
queryparam = "\""+view+ " id:'" + id + "'"
sleep 0.2
if (query(queryparam).to_s.include? id) == true
return true
else
count = count + 1
 if ((query(queryparam).to_s.include? id) == false && count >= 100) then
return false
else end 
end
end
end

