import 'package:twelve_clock/services/network.dart';
import 'package:twelve_clock/services/location.dart';
import 'package:twelve_clock/cred.dart';

class WeatherModel {
  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        url: Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=metric"));
    var weatherData = await networkHelper.getData();
    return weatherData;
  }
}
