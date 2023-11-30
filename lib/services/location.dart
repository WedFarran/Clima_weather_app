import 'package:geolocator/geolocator.dart';

class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    try {
      Geolocator.checkPermission().then((permission) {
        if (permission == LocationPermission.denied) {
          Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            Geolocator.requestPermission();
          }
        }
      });
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (error) {
      throw 'cant access location';
    }
  }
}

/*https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=${dotenv.env['VAR_NAME']}*/
