class ApiEndpoints {
  static const String baseUrl = 'https://api.openweathermap.org';
  static const String _apiKey = '71ced824c06aeece5832d666f4f632a8';

  static String getCityWeather(String city) {
    return '$baseUrl/data/2.5/weather?q=$city&units=metric&appid=$_apiKey';
  }
}
