require 'sinatra'
require 'timezone'

get '/'  do 
	erb :form
end

post '/' do
	
	city_name = params[:message]
	timezones_array = Timezone::Zone.names
	search_zone = timezones_array.find { |e| /#{city_name}/ =~ e}
	timezone=Timezone::Zone.new :zone => search_zone
	time_show = timezone.time Time.now
	time_date = time_show.to_s.split(' ')
	time = time_date [1]
	time_split = time.split(':')
	hours = time_split[0]
	minutes = time_split[1]

	if hours.to_i >12
		hours_current = hours.to_i - 12
		suffix = "PM"
	else
		hours_current = hours
		suffix = "AM"
	end


	
	"The current time in #{city_name} is: " + hours_current.to_s + ":" + minutes.to_s+suffix
end

