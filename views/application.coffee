DAY = 24 * 60 * 60 * 1000
DEPARTURE_DATE = new Date(Date.UTC(2012, 11, 17, 23))
UPDATE_INTERVAL = 30 * 1000

days_to_departure = ->
  today = new Date
  Math.ceil((DEPARTURE_DATE.getTime() - today.getTime()) / DAY)

update_countdown = ->
  document.getElementById('countdown').innerHTML = days_to_departure()

window.onload = ->
  setInterval(update_countdown, UPDATE_INTERVAL)
