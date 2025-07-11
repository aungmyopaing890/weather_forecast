import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/entity/weather_entity.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late WeatherBloc viewModel;
  late MockTemperatureUnitCubit mockTemperatureUnitCubit;

  late MockFetchWeatherUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockFetchWeatherUseCase();
    mockTemperatureUnitCubit = MockTemperatureUnitCubit();
    when(mockTemperatureUnitCubit.stream)
        .thenAnswer((_) => const Stream.empty());
    viewModel = WeatherBloc(mockUseCase, mockTemperatureUnitCubit);
  });

  const testCity = 'Bangkok';

  final weatherEntity = WeatherEntity(
    cityName: testCity,
    description: 'Cloudy',
    iconCode: '10d',
    temperature: 301.5,
    humidity: 70,
    windSpeed: 4.2,
    feelsLike: 300.0,
  );

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherLoaded] when FetchWeather succeeds',
    build: () {
      when(mockUseCase.call(testCity)).thenAnswer((_) async => weatherEntity);
      return viewModel;
    },
    act: (bloc) => bloc.add(FetchWeather(testCity)),
    expect: () => [
      WeatherLoading(),
      WeatherLoaded(weather: weatherEntity, unit: TemperatureUnit.celsius),
    ],
    verify: (_) {
      verify(mockUseCase.call(testCity)).called(1);
    },
  );

  blocTest<WeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherError] when FetchWeather fails',
    build: () {
      when(mockUseCase.call(testCity)).thenThrow(Exception('Failed to fetch'));
      return viewModel;
    },
    act: (bloc) => bloc.add(FetchWeather(testCity)),
    expect: () => [
      WeatherLoading(),
      isA<WeatherError>(),
    ],
    verify: (_) {
      verify(mockUseCase.call(testCity)).called(1);
    },
  );
}
