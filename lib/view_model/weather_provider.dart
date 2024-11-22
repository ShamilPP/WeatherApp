import 'package:flutter/material.dart';
import 'package:weather_app/model/weather.dart';

import '../model/result.dart';
import '../services/remote/api/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  Result<Weather> _weather = Result();

  Result<Weather> get weather => _weather;

  Future loadWeather(String city) async {
    _weather.setStatus(ResultStatus.loading);
    notifyListeners();
    try {
      _weather = await WeatherService.getWeatherWithCity(city);
      notifyListeners();
    } catch (e) {
      _weather.setStatus(ResultStatus.failed);
      notifyListeners();
    }
  }
}
