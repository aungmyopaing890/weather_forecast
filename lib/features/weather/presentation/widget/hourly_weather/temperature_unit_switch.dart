import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';

class TemperatureUnitSwitch extends StatelessWidget {
  const TemperatureUnitSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
      builder: (context, unit) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('°C'),
            Switch(
              value: unit == TemperatureUnit.fahrenheit,
              onChanged: (_) {
                context.read<TemperatureUnitCubit>().toggleUnit();
              },
            ),
            const Text('°F'),
          ],
        );
      },
    );
  }
}
