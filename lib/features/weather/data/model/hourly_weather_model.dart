import '../../domain/entity/hourly_weather_entity.dart';

class HourlyWeatherModel extends HourlyWeatherEntity {
  const HourlyWeatherModel({
    required super.time,
    super.temperature = 0.0,
    super.humidity = 0,
    super.icon = '',
  });

  factory HourlyWeatherModel.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherModel(
      time: json['dt_txt'] != null
          ? DateTime.parse(json['dt_txt'] ?? '').toLocal()
          : DateTime.now(),
      temperature: (json['main']?['temp']) ?? 0.0,
      humidity: (json['main']?['humidity']) ?? 0,
      icon: (json['weather'] != null && json['weather'].isNotEmpty)
          ? json['weather'][0]['icon'] ?? ''
          : '',
    );
  }
}
