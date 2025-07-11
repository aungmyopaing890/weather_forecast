import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';

class TemperatureUnitCubit extends Cubit<TemperatureUnit> {
  TemperatureUnitCubit() : super(TemperatureUnit.celsius);

  void toggleUnit() {
    final newUnit = state == TemperatureUnit.celsius
        ? TemperatureUnit.fahrenheit
        : TemperatureUnit.celsius;
    emit(newUnit);
  }
}
