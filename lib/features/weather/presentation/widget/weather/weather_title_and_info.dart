import 'package:flutter/material.dart';

class WeatherTitleAndInfo extends StatelessWidget {
  const WeatherTitleAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text('Weather Forecast',
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter City Name (English)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}
