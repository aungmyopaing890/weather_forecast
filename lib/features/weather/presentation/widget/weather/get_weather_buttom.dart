import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/config/router/route_paths.dart';
import 'package:weather_forecast/features/weather/data/holder/city_intent_holder.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';

class GetWeatherButtom extends StatelessWidget {
  const GetWeatherButtom({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6F0FF),
                foregroundColor: const Color(0xFF4A90E2),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final city = controller.text.trim();

                if (city.isNotEmpty) {
                  context.read<WeatherBloc>().add(FetchWeather(city));
                }
              },
              icon: const Icon(Icons.sync),
              label: const Text('Get Weather'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6F0FF),
                foregroundColor: const Color(0xFF4A90E2),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final city = controller.text.trim();
                if (city.isNotEmpty) {
                  Navigator.pushNamed(
                    context,
                    RoutePaths.hourlyForecast,
                    arguments: CityIntentHolder(city),
                  );
                }
              },
              icon: const Icon(Icons.access_time, size: 18),
              label: const Text('24-Hour Forecast'),
            ),
          ),
        ],
      ),
    );
  }
}
