import 'package:equatable/equatable.dart';

class HourlyWeatherEntity extends Equatable {
  final DateTime time;
  final double temperature;
  final int humidity;
  final String icon;

  const HourlyWeatherEntity({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.icon,
  });

  @override
  List<Object?> get props => [time, temperature, humidity, icon];
}
