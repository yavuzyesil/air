import 'package:flutter/material.dart';

import '/apiKey/api_key.dart';
import 'location_services.dart';
import 'network_service.dart';

class WeatherService {
  String headURL = "http://api.openweathermap.org/data/2.5/weather?";
  String urlComp = "";
  String city = "";
  LocationService locationService = LocationService();
  NetworkService? networkService;

  Future getLocationFromCoord() async {
    await locationService.getLocation();
    urlComp =
        "${headURL}lat=${locationService.latitude}&lon=${locationService.longitude}&units=metric&appid=$apiKEY";
    debugPrint(urlComp);
    networkService = NetworkService(url: urlComp);
    var networkData = await networkService?.getData();
    return networkData;
  }

  Future getLocationFromInput({required String city}) async {
    urlComp = "${headURL}q=$city&units=metric&appid=$apiKEY";
    debugPrint(urlComp);
    networkService = NetworkService(url: urlComp);
    var networkData = await networkService?.getData();
    if (networkData != int) {
      return networkData;
    } else {
      return null;
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
