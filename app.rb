require "sinatra"
require "sinatra/reloader" if development?
require "haml"
require "yahoo_weatherman"

ARUBA_WOEID = 23424736
DEPARTURE_DATE = Time.new(2012, 12, 18)
SECONDS_PER_DAY = 86400

get '/' do
  time_remaining = DEPARTURE_DATE - Time.now
  @days_to_departure = (time_remaining / SECONDS_PER_DAY).to_i

  client = Weatherman::Client.new
  weather = client.lookup_by_woeid ARUBA_WOEID
  @image = weather.description_image.values.first
  @forecast_low = weather.forecasts.first['low']
  @forecast_high = weather.forecasts.first['high']
  @temp = weather.condition['temp']
  haml :countdown
end
