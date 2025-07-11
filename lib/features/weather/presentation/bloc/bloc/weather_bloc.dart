import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_weather_usecase.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/weather_event.dart';
import '../state/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final FetchWeatherUseCase fetchWeatherUseCase;
  final TemperatureUnitCubit unitCubit;

  late final StreamSubscription _unitSubscription;
  TemperatureUnit _unit = TemperatureUnit.celsius;

  WeatherBloc(this.fetchWeatherUseCase, this.unitCubit)
      : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);

    _unitSubscription = unitCubit.stream.listen((newUnit) {
      _unit = newUnit;
      if (state is WeatherLoaded) {
        final current = (state as WeatherLoaded).weather;
        add(FetchWeather(current.cityName));
      }
    });
  }

  Future<void> _onFetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await fetchWeatherUseCase(event.city);
      emit(WeatherLoaded(weather: weather, unit: _unit));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _unitSubscription.cancel();
    return super.close();
  }
}
