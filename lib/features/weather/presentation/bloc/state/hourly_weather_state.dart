import 'package:equatable/equatable.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';

abstract class HourlyWeatherState extends Equatable {
  const HourlyWeatherState();

  @override
  List<Object?> get props => [];
}

class HourlyWeatherInitial extends HourlyWeatherState {
  const HourlyWeatherInitial();
}

class HourlyWeatherLoading extends HourlyWeatherState {
  const HourlyWeatherLoading();
}

class HourlyWeatherLoaded extends HourlyWeatherState {
  final List<HourlyWeatherEntity> dataList;
  final TemperatureUnit unit;

  const HourlyWeatherLoaded({
    required this.dataList,
    this.unit = TemperatureUnit.celsius,
  });

  @override
  List<Object?> get props => [dataList, unit];
}

class HourlyWeatherError extends HourlyWeatherState {
  final String message;

  const HourlyWeatherError(this.message);

  @override
  List<Object?> get props => [message];
}
