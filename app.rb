require "sinatra"
require "sinatra/reloader" if development?
require "coffee-script"
require "v8"
require "haml"
require "yahoo_weatherman"


ARUBA_WOEID = 23424736
DEPARTURE_DATE = Time.new(2012, 12, 18, 0, 0, 0, "+01:00")
SECONDS_PER_DAY = 86400

get '/' do
  time_remaining = DEPARTURE_DATE - Time.now
  @days_to_departure = (time_remaining / SECONDS_PER_DAY).ceil

  client = Weatherman::Client.new
  weather = client.lookup_by_woeid ARUBA_WOEID
  @image = weather.description_image.values.first
  @forecast_low = weather.forecasts.first['low']
  @forecast_high = weather.forecasts.first['high']
  @current_temperature = weather.condition['temp']
  @current_condition = weather.condition['text']
  haml :countdown
end

get '/countdown.js' do
  coffee :countdown
end