# WWeather 

WWeather is a Waybar Weather module.

The script uses the Open-Meteo API, retrieving weather data based on the latitude and longitude of the selected city and province, and outputs the current temperature along with a weather condition icon.

<p></p>
<img width="1069" height="1025" alt="image" src="https://github.com/user-attachments/assets/900b4b25-d323-4075-9b0a-56ac877c78e4" />
<p></p>

Waybar config:
```
{
  "custom/weather": {
    "format": "{}",
    "exec": "~/.config/waybar/scripts/wweather.sh",
    "interval": 600,
    "tooltip": false
  }
}
```
