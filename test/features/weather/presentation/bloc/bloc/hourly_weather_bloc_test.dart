import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/entity/hourly_weather_entity.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/hourly_weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/hourly_weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';

import '../../../../../helper/test_helper.mocks.dart';

void main() {
  late HourlyWeatherBloc hourlyWeatherViewModel;
  late MockTemperatureUnitCubit mockTemperatureUnitCubit;
  late MockFetchHourlyWeatherUseCase mockFetchHourlyWeatherUseCase;

  setUp(() {
    mockFetchHourlyWeatherUseCase = MockFetchHourlyWeatherUseCase();
    mockTemperatureUnitCubit = MockTemperatureUnitCubit();
    when(mockTemperatureUnitCubit.stream)
        .thenAnswer((_) => const Stream.empty());
    when(mockTemperatureUnitCubit.state).thenReturn(TemperatureUnit.celsius);
    hourlyWeatherViewModel = HourlyWeatherBloc(
        mockFetchHourlyWeatherUseCase, mockTemperatureUnitCubit);
  });

  const tCity = 'Bangkok';
  final tHourlyWeatherList = [
    HourlyWeatherEntity(
      time: DateTime.parse('2025-07-10T10:00:00Z'),
      temperature: 303.15,
      humidity: 60,
      icon: '10d',
    ),
  ];

  const tFetchEvent = FetchHourlyWeather(city: tCity);

  group('FetchHourlyWeather', () {
    blocTest<HourlyWeatherBloc, HourlyWeatherState>(
      'emits [HourlyWeatherLoading, HourlyWeatherLoaded] when successful',
      setUp: () {
        when(mockFetchHourlyWeatherUseCase.call(tCity))
            .thenAnswer((_) async => tHourlyWeatherList);
      },
      build: () => hourlyWeatherViewModel,
      act: (bloc) => bloc.add(tFetchEvent),
      expect: () => <HourlyWeatherState>[
        const HourlyWeatherLoading(),
        HourlyWeatherLoaded(dataList: tHourlyWeatherList),
      ],
      verify: (_) {
        verify(mockFetchHourlyWeatherUseCase.call(tCity)).called(1);
      },
    );

    blocTest<HourlyWeatherBloc, HourlyWeatherState>(
      'emits [HourlyWeatherLoading, HourlyWeatherError] when it fails',
      setUp: () {
        when(mockFetchHourlyWeatherUseCase.call(tCity))
            .thenThrow(Exception('Something went wrong'));
      },
      build: () => hourlyWeatherViewModel,
      act: (bloc) => bloc.add(tFetchEvent),
      expect: () => <HourlyWeatherState>[
        const HourlyWeatherLoading(),
        const HourlyWeatherError('Exception: Something went wrong'),
      ],
      verify: (_) {
        verify(mockFetchHourlyWeatherUseCase.call(tCity)).called(1);
      },
    );
  });
}
