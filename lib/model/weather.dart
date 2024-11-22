class Weather {
  final String name;
  final String main; // Weather condition (e.g., Rain, Clear)
  final String description; // Detailed weather description (e.g., light rain)
  final String icon; // Icon code for weather condition
  final double temp; // Current temperature
  final double tempMin; // Minimum temperature
  final double tempMax; // Maximum temperature
  final int humidity; // Humidity percentage
  final int cloudiness; // Cloudiness percentage
  final double windSpeed; // Wind speed in meters/second

  Weather({
    required this.name,
    required this.main,
    required this.description,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.cloudiness,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      name: json['name'],
      main: json['weather'][0]['main'] as String,
      description: json['weather'][0]['description'] as String,
      icon: json['weather'][0]['icon'] as String,
      temp: (json['main']['temp'] as num).toDouble(),
      tempMin: (json['main']['temp_min'] as num).toDouble(),
      tempMax: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'] as int,
      cloudiness: json['clouds']['all'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
