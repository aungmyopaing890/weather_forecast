import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/data/model/hourly_weather_model.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/hourly_weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/screen/hourly_weather_screen.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockHourlyWeatherBloc mockHourlyWeatherBloc;
  late MockTemperatureUnitCubit mockTemperatureUnitCubit;
  setUpAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    mockHourlyWeatherBloc = MockHourlyWeatherBloc();
    mockTemperatureUnitCubit = MockTemperatureUnitCubit();
  });

  Widget createWidgetWithState(HourlyWeatherState state) {
    when(mockHourlyWeatherBloc.state).thenReturn(state);
    when(mockHourlyWeatherBloc.stream).thenAnswer((_) => Stream.value(state));

    when(mockTemperatureUnitCubit.state).thenReturn(TemperatureUnit.celsius);
    when(mockTemperatureUnitCubit.stream)
        .thenAnswer((_) => Stream.value(TemperatureUnit.celsius));

    return MultiBlocProvider(
      providers: [
        BlocProvider<HourlyWeatherBloc>.value(value: mockHourlyWeatherBloc),
        BlocProvider<TemperatureUnitCubit>.value(
            value: mockTemperatureUnitCubit),
      ],
      child: MaterialApp(
        home: HourlyWeatherScreen(
          city: 'Bangkok',
          bloc: mockHourlyWeatherBloc,
        ),
      ),
    );
  }

  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    await tester.pumpWidget(createWidgetWithState(HourlyWeatherLoading()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when error state', (tester) async {
    await tester
        .pumpWidget(createWidgetWithState(HourlyWeatherError('API error')));
    expect(find.textContaining('API error'), findsOneWidget);
  });

  testWidgets('shows full weather card with data', (tester) async {
    final mockData = [
      HourlyWeatherModel(
        time: DateTime(2025, 7, 10, 10, 0), // 10:00 AM
        temperature: 303.15, // 30°C
        humidity: 60,
        icon: '10d',
      ),
    ];

    await tester.pumpWidget(
      createWidgetWithState(
        HourlyWeatherLoaded(
          dataList: mockData,
          unit: TemperatureUnit.celsius,
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);
    expect(find.textContaining('Humidity: 60%'), findsOneWidget);
    expect(find.textContaining('30.0 °C'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });
}
