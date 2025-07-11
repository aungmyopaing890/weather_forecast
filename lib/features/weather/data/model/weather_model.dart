import 'package:weather_forecast/features/weather/domain/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    super.cityName = "",
    super.description = "",
    super.iconCode = "",
    super.temperature = 0.0,
    super.feelsLike = 0.0,
    super.humidity = 0,
    super.windSpeed = 0.0,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? "",
      description: (json['weather'] != null &&
              json['weather'] is List &&
              json['weather'].isNotEmpty)
          ? json['weather'][0]['description'] ?? ""
          : "",
      iconCode: (json['weather'] != null &&
              json['weather'] is List &&
              json['weather'].isNotEmpty)
          ? json['weather'][0]['icon'] ?? ""
          : "",
      temperature: (json['main'] != null && json['main']['temp'] != null)
          ? (json['main']['temp'] as num).toDouble()
          : 0.0,
      feelsLike: (json['main'] != null && json['main']['feels_like'] != null)
          ? (json['main']['feels_like'] as num).toDouble()
          : 0.0,
      humidity: (json['main'] != null && json['main']['humidity'] != null)
          ? json['main']['humidity'] as int
          : 0,
      windSpeed: (json['wind'] != null && json['wind']['speed'] != null)
          ? (json['wind']['speed'] as num).toDouble()
          : 0.0,
    );
  }
}
