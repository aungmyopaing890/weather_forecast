import 'package:get_it/get_it.dart';
import 'package:weather_forecast/features/weather/data/datasources/weather_api_service_impl.dart';
import 'package:weather_forecast/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_forecast/features/weather/domain/data_sources/weather_api_service.dart';
import 'package:weather_forecast/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_hourly_weather_usecase.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_weather_usecase.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  _injectServices();
  _injectCubits();
  _injectRepositories();
  _injectUseCases();
  _injectViewModels();
}

void _injectServices() {
  locator
      .registerLazySingleton<WeatherApiService>(() => WeatherApiServiceImpl());
}

void _injectCubits() {
  locator.registerLazySingleton<TemperatureUnitCubit>(
      () => TemperatureUnitCubit());
}

void _injectRepositories() {
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(locator<WeatherApiService>()),
  );
}

void _injectUseCases() {
  locator.registerLazySingleton(
      () => FetchWeatherUseCase(locator<WeatherRepository>()));
  locator.registerLazySingleton(
      () => FetchHourlyWeatherUseCase(locator<WeatherRepository>()));
}

void _injectViewModels() {
  locator.registerFactory(() => WeatherBloc(
      locator<FetchWeatherUseCase>(), locator<TemperatureUnitCubit>()));
  locator.registerFactory(() => HourlyWeatherBloc(
      locator<FetchHourlyWeatherUseCase>(), locator<TemperatureUnitCubit>()));
}
