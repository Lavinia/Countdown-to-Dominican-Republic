require "sinatra"
require "yahoo_weatherman"

ARUBA_WOEID = 23424736
DEPARTURE_DATE = Time.new(2012, 12, 18)
SECONDS_PER_DAY = 86400

get '/' do
  time_remaining = DEPARTURE_DATE - Time.now
  days_remaining = (time_remaining / SECONDS_PER_DAY).to_i
  # days_remaining.to_s

  client = Weatherman::Client.new
  weather = client.lookup_by_woeid ARUBA_WOEID
  # weather.description
  days_remaining.to_s + " days to departure<br>" + weather.description
end
