import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:weather_forecast/config/end_point/end_point.dart';
import 'package:weather_forecast/features/weather/data/datasources/weather_api_service_impl.dart';
import 'package:weather_forecast/features/weather/data/model/weather_model.dart';
import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';

import '../../../../helper/test_helper.mocks.dart';
import '../../../../helper/json_reader.dart';

void main() {
  late MockClient mockClient;
  late WeatherApiServiceImpl service;

  const city = 'Bangkok';

  setUp(() {
    mockClient = MockClient();
    service = WeatherApiServiceImpl(client: mockClient);
  });

  group('fetchWeather', () {
    test('returns WeatherModel when successful', () async {
      final response = readJson('weather_response_success.json');
      final uri = Uri.parse('${EndPoint.weatherByCity}&q=$city');

      when(mockClient.get(uri)).thenAnswer(
        (_) async => http.Response(response, 200),
      );

      final result = await service.fetchWeather(city);
      expect(result, isA<WeatherModel>());
      expect(result.cityName, city);
    });

    test('throws exception when city not found', () async {
      final response = readJson('weather_response_not_found.json');
      final uri = Uri.parse('${EndPoint.weatherByCity}&q=$city');

      when(mockClient.get(uri)).thenAnswer(
        (_) async => http.Response(response, 200),
      );

      expect(() => service.fetchWeather(city), throwsException);
    });
  });

  group('fetchHourlyWeather', () {
    test('returns List<HourlyWeatherEntity> when successful', () async {
      final response = readJson('hourly_weather_response_success.json');
      final uri = Uri.parse('${EndPoint.hourlyForecast}&q=$city');

      when(mockClient.get(uri)).thenAnswer(
        (_) async => http.Response(response, 200),
      );

      final result = await service.fetchHourlyWeather(city);
      expect(result, isA<List<HourlyWeatherEntity>>());
    });

    test('throws exception if city not found', () async {
      final response = readJson('hourly_weather_response_not_found.json');
      final uri = Uri.parse('${EndPoint.hourlyForecast}&q=$city');

      when(mockClient.get(uri)).thenAnswer(
        (_) async => http.Response(response, 200),
      );

      expect(() => service.fetchHourlyWeather(city), throwsException);
    });
  });
}
