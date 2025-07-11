import 'package:equatable/equatable.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/entity/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity weather;
  final TemperatureUnit? unit;

  const WeatherLoaded({
    required this.weather,
    this.unit,
  });

  @override
  List<Object?> get props => [weather, unit];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
