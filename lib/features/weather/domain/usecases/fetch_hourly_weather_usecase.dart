import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';
import 'package:weather_forecast/features/weather/domain/repository/weather_repository.dart';

class FetchHourlyWeatherUseCase {
  final WeatherRepository repository;

  FetchHourlyWeatherUseCase(this.repository);

  Future<List<HourlyWeatherEntity>> call(String city) {
    return repository.fetchHourlyWeather(city);
  }
}
