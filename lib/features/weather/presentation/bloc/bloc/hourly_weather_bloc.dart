import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_hourly_weather_usecase.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/hourly_weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/hourly_weather_state.dart';

class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  final FetchHourlyWeatherUseCase fetchWeatherUseCase;
  final TemperatureUnitCubit unitCubit;

  late final StreamSubscription _unitSubscription;

  TemperatureUnit _currentUnit = TemperatureUnit.celsius;
  String? _lastCity;
  List<dynamic>? _cachedData;

  HourlyWeatherBloc(this.fetchWeatherUseCase, this.unitCubit)
      : super(HourlyWeatherInitial()) {
    on<FetchHourlyWeather>(_onFetchWeather);

    _unitSubscription = unitCubit.stream.listen((newUnit) {
      _currentUnit = newUnit;
      if (state is HourlyWeatherLoaded && _cachedData != null) {
        add(FetchHourlyWeather(city: _lastCity!));
      }
    });
  }

  Future<void> _onFetchWeather(
      FetchHourlyWeather event, Emitter<HourlyWeatherState> emit) async {
    emit(HourlyWeatherLoading());
    try {
      final weather = await fetchWeatherUseCase(event.city);
      _lastCity = event.city;
      _cachedData = weather;
      emit(HourlyWeatherLoaded(dataList: weather, unit: _currentUnit));
    } catch (e) {
      emit(HourlyWeatherError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _unitSubscription.cancel();
    return super.close();
  }
}
