import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/event/weather_event.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/weather_bloc.dart';

class WeatherTextField extends StatelessWidget {
  const WeatherTextField({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        final city = controller.text.trim();
        if (city.isNotEmpty) {
          context.read<WeatherBloc>().add(FetchWeather(city));
        }
      },
      decoration: InputDecoration(
        hintText: 'e.g., Bangkok, Tokyo, New York',
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
