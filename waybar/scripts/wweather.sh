#!/bin/bash

#Avoid loading partial output on waybar at startup.
while ! ping -c1 api.open-meteo.com &>/dev/null; do
    sleep 1
done

#Set city and province.
city="Brusciano"
province="Naples"

#Retrieve geodata from the chosen city and province.
geodata=$(curl -s "https://geocoding-api.open-meteo.com/v1/search?name=${city}" \
| jq ".results[] | select(.admin2 == \"${province}\")")

#Extract latitude from geodata.
latitude=$(echo "$geodata" | jq -r '.latitude')

#Extract longitude from geodata.
longitude=$(echo "$geodata" | jq -r '.longitude')

#Retrieve the weather for a given latitude and longitude.
weather=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=${latitude}&longitude=${longitude}&current_weather=true")

#Extract temperature.
temperature=$(echo "$weather" | jq -r '.current_weather.temperature | floor')

#Extract weathercode.
icon=$(echo "$weather" | jq -r '.current_weather.weathercode')

#Convert weathercode to icon.
case $icon in
  0)						icon="";;	#Sun
  1|2|3)					icon="";;	#Cloud
  45|48)        				icon="";;	#Fog
  71|73|75|77|85|86)     			icon="";;	#Snow
  51|53|55|56|57|61|63|65|66|67|80|81|82)       icon="";;	#Rain
  95|96|99)        				icon="";;	#Thunderstorm
esac

#Output the icon and temperature.
echo "  ${icon} ${temperature}°C "
