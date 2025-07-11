import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/model/weather_model.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_weather_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockRepository;

  late FetchWeatherUseCase useCase;

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = FetchWeatherUseCase(mockRepository);
  });

  test('should return WeatherEntity when fetch is successful', () async {
    const city = 'Bangkok';
    final weatherEntity = WeatherModel(
      temperature: 300.0,
      description: 'Sunny',
      humidity: 50,
      windSpeed: 4.5,
      iconCode: '01d',
      cityName: "Bangkok",
    );

    when(mockRepository.fetchWeather(city))
        .thenAnswer((_) async => weatherEntity);

    final result = await useCase(city);

    expect(result, weatherEntity);
    verify(mockRepository.fetchWeather(city)).called(1);
  });

  test('should throw an exception when repository throws', () async {
    const city = 'Bangkok';
    when(mockRepository.fetchWeather(city))
        .thenThrow(Exception('Failed to fetch weather'));

    expect(() => useCase(city), throwsA(isA<Exception>()));
    verify(mockRepository.fetchWeather(city)).called(1);
  });

  test('should throw custom error string if fetch fails', () async {
    const city = 'Bangkok';
    when(mockRepository.fetchWeather(city)).thenThrow('Custom Error');

    expect(() => useCase(city), throwsA(isA<String>()));
    verify(mockRepository.fetchWeather(city)).called(1);
  });
}
