DAY = 24 * 60 * 60 * 1000
DEPARTURE_DATE = new Date('2012-12-18')
UPDATE_INTERVAL = 30 * 1000

days_to_departure = ->
  today = new Date
  Math.round((DEPARTURE_DATE.getTime() - today.getTime()) / DAY)

update_countdown = ->
  document.getElementById('countdown').innerHTML = days_to_departure()

window.onload = ->
  setInterval(update_countdown, UPDATE_INTERVAL)
