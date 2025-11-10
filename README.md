# WWeather 

WWeather is a Waybar Weather module.

The script uses the Open-Meteo API, retrieving weather data based on the latitude and longitude of the selected city and province, and outputs the current temperature along with a weather condition icon.


<img width="74" height="35" alt="sample" src="https://github.com/user-attachments/assets/c9d81dbe-8290-4db5-a0d7-a5abdcee3acf" />


Waybar config:
```
{
 "custom/weather": {
 "format": "{}",
 "exec": "~/.config/waybar/scripts/wweather.sh",
 "interval": 3600,
 "tooltip": false
 }
}
```
