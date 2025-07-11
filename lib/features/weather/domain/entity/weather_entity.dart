import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final String description;
  final String iconCode;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;

  const WeatherEntity({
    required this.cityName,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });
  @override
  List<Object> get props => [
        cityName,
        temperature,
        humidity,
        feelsLike,
        windSpeed,
        iconCode,
      ];
}
