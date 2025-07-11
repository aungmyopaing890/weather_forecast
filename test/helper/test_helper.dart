import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:weather_forecast/features/weather/domain/data_sources/weather_api_service.dart';
import 'package:weather_forecast/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_hourly_weather_usecase.dart';
import 'package:weather_forecast/features/weather/domain/usecases/fetch_weather_usecase.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';

@GenerateMocks(
  [
    WeatherApiService,
    FetchWeatherUseCase,
    FetchHourlyWeatherUseCase,
    WeatherRepository,
    HourlyWeatherBloc,
    TemperatureUnitCubit,
    WeatherBloc,
    http.Client,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
