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

  List<String> getWeatherIconAndComment(int condition) {
    if (condition < 400) {
      return ['thunderstorm', 'Thunderstorms are approaching.\nWatch out!'];
    } else if (condition < 600) {
      return ['heavy_rain', 'It\'s rainy.\nDon\'t forget an umbrella.'];
    } else if (condition < 700) {
      return ['snowfall', 'Snow is falling.\nWatch out for slippery roads.'];
    } else if (condition < 800) {
      return ['foggy', 'It\'s foggy.\nBe careful when driving.'];
    } else if (condition == 800) {
      return ['clear_sky', 'Time for shorts and t-shirts!'];
    } else if (condition <= 804) {
      return ['cloudy', 'It\'s cloudy, but don\'t worry.\nEvery cloud has a silver lining!'];
    } else {
      return ['background1', 'Unable to get weather data'];
    }
  }
}
