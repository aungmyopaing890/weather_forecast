import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast/features/common/error_text.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/hourly_weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';

class HourlyWeatherListView extends StatelessWidget {
  const HourlyWeatherListView({super.key});

  double _kelvinToCelsius(double k) => k - 273.15;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
      builder: (context, state) {
        if (state is HourlyWeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HourlyWeatherError) {
          return Center(child: ErrorText(message: state.message));
        } else if (state is HourlyWeatherLoaded) {
          final hourlyList = state.dataList;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: hourlyList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final weather = hourlyList[index];
              final isFahrenheit = state.unit == TemperatureUnit.fahrenheit;
              final temp = isFahrenheit
                  ? (_kelvinToCelsius(weather.temperature) * 9 / 5 + 32)
                  : _kelvinToCelsius(weather.temperature);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.network(
                      'http://openweathermap.org/img/wn/${weather.icon}@2x.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('hh:mm a').format(weather.time),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Humidity: ${weather.humidity}%',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      '${temp.toStringAsFixed(1)} ${state.unit.symbol}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: Text('Enter a city to get started'));
      },
    );
  }
}
