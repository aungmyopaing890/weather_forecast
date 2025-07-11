import 'package:flutter/material.dart';

class WeatherInfoRow extends StatelessWidget {
  const WeatherInfoRow({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.bgColor,
  });

  final String title;
  final String value;
  final Color? valueColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}
