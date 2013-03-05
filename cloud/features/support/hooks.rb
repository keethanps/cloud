
Before do |scenario|

end

After do |scenario|
  if scenario.failed?

if $browser.exist? 
takewebscreenshot
$webscreenshot_count += 1
$browser.close
else
end
else
#pass case
#if $browser.exist? 
#$browser.close
#else
#end
end
end

After('@client') do
   begin
  shutdown_test_server
rescue Exception => e
 puts "Shutting down the test server"
end
end
