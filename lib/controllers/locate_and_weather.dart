import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/airdata.dart';
import 'package:weather_app/models/weatherdata.dart';

class LocationController extends GetxController {
  var lat = "0".obs;
  var lon = "0".obs;
  // ignore: deprecated_member_use
  var info = WeatherData().obs;
  var airInfo = AirData().obs;
  var isLoading = true.obs;

  @override
  void onInit() async {
    getCurrentLocation();
    // fetchWeather();

    super.onInit();
  }

  fetchWeatherAir(String lati, String long) async {
    var weatherdata = await Service.fetchWeather(lati, long);
    var airdata = await Service.fetchAirData(lati, long);
    if (weatherdata != null && airdata != null) {
      info.value = weatherdata;
      airInfo.value = airdata;
      isLoading.value = false;
    }
  }

  getCurrentLocation() async {
    // isLoading.value = true;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      fetchWeatherAir(position.latitude.toStringAsFixed(2),
          position.longitude.toStringAsFixed(2));
      lat.value = position.latitude.toStringAsFixed(2);
      lon.value = position.longitude.toStringAsFixed(2);
    }).catchError((e) {
      lat.value = "0";
      lon.value = "0";
    });
  }
}

class Service {
  static var client = http.Client();

  static Future<WeatherData> fetchWeather(String lat, String lon) async {
    var response = await client.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&appid=API_KEY"));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return weatherDataFromJson(jsonString);
    } else {
      return null;
    }
  }

  static Future<AirData> fetchAirData(String lat, String lon) async {
    var response = await client.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=API_KEY"));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return airDataFromJson(jsonString);
    } else {
      return null;
    }
  }
}
