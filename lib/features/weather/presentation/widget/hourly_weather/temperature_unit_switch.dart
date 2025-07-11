import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/state/hourly_weather_state.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/hourly_weather_bloc.dart';

class TemperatureUnitSwitch extends StatelessWidget {
  const TemperatureUnitSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('°C'),
            BlocBuilder<TemperatureUnitCubit, TemperatureUnit>(
              builder: (context, unit) {
                return Switch(
                  value: context.select((HourlyWeatherBloc vm) =>
                      vm.state is HourlyWeatherLoaded &&
                      (vm.state as HourlyWeatherLoaded).unit ==
                          TemperatureUnit.fahrenheit),
                  onChanged: (_) {
                    context.read<TemperatureUnitCubit>().toggleUnit();
                  },
                );
              },
            ),
            const Text('°F'),
          ],
        );
      },
    );
  }
}
