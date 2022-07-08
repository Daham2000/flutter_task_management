import 'package:location/location.dart';
import 'package:weather/weather.dart';

class WeatherAPI {
  WeatherFactory wf = WeatherFactory("bc12083e70d2d22298c2df1cec7101d9");

  Future<double> getWeather() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
      }

      locationData = await location.getLocation();
      Weather w = await wf.currentWeatherByLocation(
          locationData.latitude ?? 0, locationData.longitude ?? 0);
      return w.temperature?.celsius ?? 0;
    } catch (e) {
      print("Weather API Endpoint Error Message: " + e.toString());
      return 0.0;
    }
  }
}
