import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/model/hourly_weather_model.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_hourly_weather_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRepository mockRepository;
  late FetchHourlyWeatherUseCase useCase;

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = FetchHourlyWeatherUseCase(mockRepository);
  });

  test('should return List<HourlyWeatherEntity> when fetch is successful',
      () async {
    // arrange
    const city = 'Bangkok';
    final mockData = [
      HourlyWeatherModel(
        time: DateTime.parse('2025-07-10T10:00:00Z'),
        temperature: 303.15,
        humidity: 60,
        icon: '10d',
      ),
      HourlyWeatherModel(
        time: DateTime.parse('2025-07-10T13:00:00Z'),
        temperature: 305.15,
        humidity: 55,
        icon: '01d',
      ),
    ];

    when(mockRepository.fetchHourlyWeather(city))
        .thenAnswer((_) async => mockData);

    // act
    final result = await useCase(city);

    // assert
    expect(result, mockData);
    verify(mockRepository.fetchHourlyWeather(city)).called(1);
  });

  test('should throw exception when repository throws', () async {
    const city = 'Bangkok';

    when(mockRepository.fetchHourlyWeather(city))
        .thenThrow(Exception('API error'));

    expect(() => useCase(city), throwsA(isA<Exception>()));
    verify(mockRepository.fetchHourlyWeather(city)).called(1);
  });

  test('should throw custom error string if fetch fails', () async {
    const city = 'Bangkok';

    when(mockRepository.fetchHourlyWeather(city)).thenThrow('Custom Error');

    expect(() => useCase(city), throwsA(isA<String>()));
    verify(mockRepository.fetchHourlyWeather(city)).called(1);
  });
}
