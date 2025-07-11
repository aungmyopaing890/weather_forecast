import 'package:weather_forecast/features/weather/domain/data_sources/weather_api_service.dart';
import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';
import 'package:weather_forecast/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_forecast/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherApiService _weatherApiService;
  WeatherRepositoryImpl(this._weatherApiService);

  @override
  Future<WeatherEntity> fetchWeather(String city) {
    try {
      return _weatherApiService.fetchWeather(city);
    } catch (e) {
      throw Exception('Failed to fetch weather: $e');
    }
  }

  @override
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(String city) {
    try {
      return _weatherApiService.fetchHourlyWeather(city);
    } catch (e) {
      throw Exception('Failed to fetch hourly weather: $e');
    }
  }
}
