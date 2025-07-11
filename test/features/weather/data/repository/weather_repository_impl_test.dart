import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/model/hourly_weather_model.dart';
import 'package:weather_forecast/features/weather/data/model/weather_model.dart';
import 'package:weather_forecast/features/weather/data/repository/weather_repository_impl.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherApiService mockApiService;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockApiService = MockWeatherApiService();
    repository = WeatherRepositoryImpl(mockApiService);
  });

  const testCity = 'Bangkok';

  final weatherEntity = WeatherModel(
    cityName: testCity,
    description: 'Cloudy',
    iconCode: '10d',
    temperature: 301.5,
    humidity: 70,
    windSpeed: 4.2,
    feelsLike: 300.0,
  );

  final hourlyWeatherList = [
    HourlyWeatherModel(
      time: DateTime.now(),
      temperature: 300.0,
      humidity: 60,
      icon: '10d',
    ),
  ];
  test('should return WeatherEntity when fetchWeather is successful', () async {
    when(mockApiService.fetchWeather(testCity))
        .thenAnswer((_) async => weatherEntity);

    final result = await repository.fetchWeather(testCity);

    expect(result, weatherEntity);
    verify(mockApiService.fetchWeather(testCity)).called(1);
  });

  test(
      'should return List<HourlyWeatherEntity> when fetchHourlyWeather is successful',
      () async {
    when(mockApiService.fetchHourlyWeather(testCity))
        .thenAnswer((_) async => hourlyWeatherList);

    final result = await repository.fetchHourlyWeather(testCity);

    expect(result, hourlyWeatherList);
    verify(mockApiService.fetchHourlyWeather(testCity)).called(1);
  });

  test('should throw exception if fetchWeather fails', () async {
    when(mockApiService.fetchWeather(testCity))
        .thenThrow(Exception('API Error'));

    expect(() => repository.fetchWeather(testCity), throwsException);
    verify(mockApiService.fetchWeather(testCity)).called(1);
  });

  test('should throw exception if fetchHourlyWeather fails', () async {
    when(mockApiService.fetchHourlyWeather(testCity))
        .thenThrow(Exception('API Error'));

    expect(() => repository.fetchHourlyWeather(testCity), throwsException);
    verify(mockApiService.fetchHourlyWeather(testCity)).called(1);
  });
}
