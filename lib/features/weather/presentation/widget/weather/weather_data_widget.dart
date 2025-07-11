import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/core/master_colors.dart';
import 'package:weather_forecast/features/common/error_text.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_box_info.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_info_card.dart';

class WeatherDataWidget extends StatelessWidget {
  const WeatherDataWidget({super.key});

  double _kelvinToCelsius(double kelvin) => kelvin - 273.15;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return CircularProgressIndicator(color: MasterColors.primary);
        } else if (state is WeatherError) {
          return ErrorText(
            message: state.message,
          );
        } else if (state is WeatherLoaded) {
          final weather = state.weather;
          final isFahrenheit = state.unit == TemperatureUnit.fahrenheit;
          final temp = isFahrenheit
              ? (_kelvinToCelsius(weather.temperature) * 9 / 5 + 32)
              : _kelvinToCelsius(weather.temperature);
          return Column(
            children: [
              WeatherInfoCard(
                  city: weather.cityName,
                  temp: temp,
                  tempUnit: isFahrenheit ? '°F' : '°C',
                  humidity: weather.humidity),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WeatherBoxInfo(
                      icon: Icons.thermostat,
                      label: 'Feels Like',
                      value:
                          '${isFahrenheit ? (temp * 9 / 5 + 32).toStringAsFixed(1) : temp.toStringAsFixed(1)}°${isFahrenheit ? 'F' : 'C'}'),
                  WeatherBoxInfo(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: '${weather.windSpeed} km/h'),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('Last updated: just now',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          );
        }
        return const Text('Enter a city to get started');
      },
    );
  }
}
