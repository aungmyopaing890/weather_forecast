import 'package:weather_forecast/features/weather/domain/repository/weather_repository.dart';
import '../entity/weather_entity.dart';

class FetchWeatherUseCase {
  final WeatherRepository repository;

  FetchWeatherUseCase(this.repository);

  Future<WeatherEntity> call(String city) {
    return repository.fetchWeather(city);
  }
}
