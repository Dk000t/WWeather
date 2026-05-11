#!/bin/bash

# Prevents the script from failing when the connection is not yet established
while ! ping -c1 api.open-meteo.com &>/dev/null; do
    sleep 1
done

# Set city, region and temperature unit
city="Brusciano"
region="Campania"
unit=celsius

# Retrieve geodata
geodata=$(curl -s "https://geocoding-api.open-meteo.com/v1/search?name=${city}" \
| jq ".results[] | select(.admin1 == \"${region}\")")

# Extract latitude
latitude=$(echo "$geodata" | jq -r '.latitude')

# Extract longitude
longitude=$(echo "$geodata" | jq -r '.longitude')

# Retrieve the weather
weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true&temperature_unit=${unit}")

# Extract temperature
temperature=$(echo "$weather" | jq -r '.current_weather.temperature | floor')

# Extract temperature unit symbol
unit_text=$(echo "$weather" | jq -r '.current_weather_units.temperature')

# Extract weathercode
icon=$(echo "$weather" | jq -r '.current_weather.weathercode')

# Extract day/night indicator
is_day=$(echo "$weather" | jq -r '.current_weather.is_day')

# Convert weathercode to icon
if [[ "$icon" -eq 0 ]]; then
  if [[ "$is_day" -eq 1 ]]; then
    icon="☀️"
  else
    icon="🌙"
  fi
else
  case $icon in
    1|2|3|45)                     		icon="☁️" ;;  # Cloud
    71|73|75|77|85|86)         			icon="🌨️";;   # Snow
    51|53|55|56|57|61|63|65|66|67|80|81|82) 	icon="🌧️";;   # Rain
    95|96|99)                  			icon="⛈️";;   # Thunderstorm
  esac
fi

# Output the icon, temperature and temperature unit
echo "${icon}  ${temperature} ${unit_text}"
