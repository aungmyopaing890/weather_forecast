import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';

import '../entity/weather_entity.dart';

abstract class WeatherApiService {
  Future<WeatherEntity> fetchWeather(String city);
  Future<List<HourlyWeatherEntity>> fetchHourlyWeather(String city);
}
