DAY = 24 * 60 * 60 * 1000
DEPARTURE_DATE = new Date(Date.UTC(2012, 11, 17, 23))
DATE_UPDATE_INTERVAL = 30 * 1000

WEATHER_UPDATE_INTERVAL = 30 * 60 * 1000

days_to_departure = ->
  today = new Date
  Math.ceil((DEPARTURE_DATE.getTime() - today.getTime()) / DAY)

update_countdown = ->
  document.getElementById('countdown').innerHTML = days_to_departure()

update_weather = ->
  req = new XMLHttpRequest()

  req.addEventListener 'readystatechange', ->
    if req.readyState is 4
      if req.status is 200 or req.status is 304
        data = req.responseText
        document.getElementById('weather').innerHTML = data
      else
        console.log "[#{new Date}] Could not fetch current weather."

  req.open 'GET', 'weather', false
  req.send()

window.onload = ->
  setInterval(update_countdown, DATE_UPDATE_INTERVAL)
  setInterval(update_weather, WEATHER_UPDATE_INTERVAL)
