import 'package:clima_app/api_key.dart';
import 'networking.dart';
import 'location.dart';

const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$openWeatherMapURL?q=$cityName&appid=$API_KEY&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);
    var weatherData = networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '${openWeatherMapURL}?'
            'lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 400) {
      return 'thunderstorm';
    } else if (condition < 600) {
      return 'heavy_rain';
    } else if (condition < 700) {
      return 'snowfall';
    } else if (condition < 800) {
      return 'foggy';
    } else if (condition == 800) {
      return 'clear_sky';
    } else if (condition <= 804) {
      return 'cloudy';
    } else {
      return 'background1';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s time to eat ice cream';
    } else if (temp > 20) {
      return 'Time for shorts and t-shirts';
    } else if (temp < 10) {
      return 'You\'ll need a scarf and glove';
    } else {
      return 'Bring a coat just in case';
    }
  }
}
