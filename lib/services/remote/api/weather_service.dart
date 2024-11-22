import 'package:weather_app/model/weather.dart';

import '../../../model/result.dart';
import '../../../utils/api_endpoints.dart';
import 'api_service.dart';

class WeatherService {
  static final ApiService apiService = ApiService();

  static Future<Result<Weather>> getWeatherWithCity(String city) async {
    final result = await apiService.get(ApiEndpoints.getCityWeather(city));
    if (result.status == ResultStatus.success) {
      Weather weather = Weather.fromJson(result.data);
      return Result.success(weather);
    } else {
      return Result.error(result.message);
    }
  }
}
