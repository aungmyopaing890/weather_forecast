import 'package:flutter/material.dart';
import 'package:weather_forecast/features/weather/presentation/widget/weather/weather_info_row.dart';

class WeatherInfoCard extends StatelessWidget {
  const WeatherInfoCard({
    super.key,
    required this.city,
    required this.temp,
    this.tempUnit = '°C',
    required this.humidity,
  });
  final String city;
  final double temp;
  final String tempUnit;
  final int humidity;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.wb_sunny_rounded,
              color: Color(0xFFFDB813), size: 50),
          const SizedBox(height: 12),
          WeatherInfoRow(title: 'City', value: city),
          const SizedBox(height: 12),
          WeatherInfoRow(
              title: 'Temperature',
              value: '${temp.toStringAsFixed(1)} $tempUnit',
              valueColor: const Color(0xFFE65C00),
              bgColor: const Color(0xFFFFF2EC)),
          const SizedBox(height: 12),
          WeatherInfoRow(
              title: 'Humidity',
              value: '$humidity%',
              valueColor: const Color(0xFF0097A7),
              bgColor: const Color(0xFFE0F7FA)),
        ],
      ),
    );
  }
}
