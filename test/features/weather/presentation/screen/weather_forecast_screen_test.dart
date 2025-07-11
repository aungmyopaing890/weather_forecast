import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/data/model/weather_model.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/screen/weather_forecast_screen.dart';

import '../../../../helper/test_helper.mocks.dart';

late MockTemperatureUnitCubit mockTemperatureUnitCubit;

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUpAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    mockTemperatureUnitCubit = MockTemperatureUnitCubit();
    when(mockTemperatureUnitCubit.state).thenReturn(TemperatureUnit.celsius);
    when(mockTemperatureUnitCubit.stream)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget createWidgetWithState(WeatherState state) {
    when(mockWeatherBloc.state).thenReturn(state);
    when(mockWeatherBloc.stream).thenAnswer((_) => Stream.value(state));

    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>.value(value: mockWeatherBloc),
        BlocProvider<TemperatureUnitCubit>.value(
            value: mockTemperatureUnitCubit),
      ],
      child: MaterialApp(
        home: WeatherForecastScreen(
          viewModel: mockWeatherBloc,
        ),
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    await tester.pumpWidget(createWidgetWithState(WeatherLoading()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when error state', (tester) async {
    await tester.pumpWidget(createWidgetWithState(WeatherError('API error')));
    expect(find.textContaining('API error'), findsOneWidget);
  });

  testWidgets('shows weather data widgets when loaded', (tester) async {
    final weatherEntity = WeatherModel(
      cityName: 'Bangkok',
      temperature: 303.15,
      humidity: 60,
      feelsLike: 305.15,
      windSpeed: 12.5,
      iconCode: '10d',
    );

    await tester.pumpWidget(
      createWidgetWithState(WeatherLoaded(weather: weatherEntity)),
    );

    await tester.pumpAndSettle();

    // expect(find.textContaining('Bangkok'), findsOneWidget);
    expect(find.textContaining('30'), findsWidgets);
    expect(find.textContaining('60'), findsWidgets);
    expect(find.textContaining('Feels Like'), findsOneWidget);
    expect(find.textContaining('Wind Speed'), findsOneWidget);
    expect(find.textContaining('Last updated'), findsOneWidget);
  });
}
