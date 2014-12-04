DAY = 24 * 60 * 60 * 1000
DEPARTURE_DATE = new Date(Date.UTC(2014, 11, 17, 23))
DATE_UPDATE_INTERVAL = 30 * 1000
BACKGROUND_UPDATE_INTERVAL = 60 * 1000
WEATHER_UPDATE_INTERVAL = 30 * 60 * 1000
SUN_TIMES_UPDATE_INTERVAL = 30 * 60 * 1000

STATE_COMPLETE = 4
HTTP_OK = 200
HTTP_NOT_MODIFIED = 304

days_to_departure = ->
  today = new Date
  Math.max(Math.ceil((DEPARTURE_DATE.getTime() - today.getTime()) / DAY), 0)

update_countdown = ->
  document.getElementById("countdown").innerHTML = days_to_departure()

update = (end_point, on_success) ->
  req = new XMLHttpRequest()

  req.addEventListener "readystatechange", ->
    if req.readyState is STATE_COMPLETE
      if req.status is HTTP_OK
        on_success(req.responseText)
      else if req.status is HTTP_NOT_MODIFIED
        # Do nothing, weather not changed.
      else
        console.log "[#{new Date}] Could not fetch current weather."

  req.open "GET", end_point, false
  req.send()

set_weather = (content) ->
  document.getElementById("weather").innerHTML = content

set_suntimes = (content) ->
  sun_times = JSON.parse(content)
  window.sun_times.sunset = new Date sun_times.sunset * 1000
  window.sun_times.sunrise = new Date sun_times.sunrise * 1000

update_weather = ->
  update("weather", set_weather)

update_sun_times = ->
  update("sun_times", set_suntimes)

day_time = ->
  now = new Date
  window.sun_times.sunrise.getTime() <= now.getTime() < window.sun_times.sunset.getTime()

update_background_image = ->
  if day_time()
    document.getElementById("content").style.backgroundImage = 'url("images/day.jpg")'
  else
    document.getElementById("content").style.backgroundImage = 'url("images/night.jpg")'

window.onload = ->
  update_background_image()
  setInterval(update_countdown, DATE_UPDATE_INTERVAL)
  setInterval(update_weather, WEATHER_UPDATE_INTERVAL)
  setInterval(update_background_image, BACKGROUND_UPDATE_INTERVAL)
  setInterval(update_sun_times, SUN_TIMES_UPDATE_INTERVAL)

