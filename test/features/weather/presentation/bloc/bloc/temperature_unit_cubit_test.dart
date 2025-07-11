import 'package:flutter_test/flutter_test.dart';
import 'package:weather_forecast/features/weather/data/enum/temperature_unit_enum.dart';
import 'package:weather_forecast/features/weather/presentation/bloc/bloc/temperature_unit_cubit.dart';

void main() {
  group('TemperatureUnitCubit', () {
    late TemperatureUnitCubit cubit;

    setUp(() {
      cubit = TemperatureUnitCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state should be Celsius', () {
      expect(cubit.state, TemperatureUnit.celsius);
    });

    test('toggleUnit should emit Fahrenheit when current is Celsius', () {
      cubit.toggleUnit();
      expect(cubit.state, TemperatureUnit.fahrenheit);
    });

    test('toggleUnit should emit Celsius when current is Fahrenheit', () {
      cubit.emit(TemperatureUnit.fahrenheit); // Set initial state manually
      cubit.toggleUnit();
      expect(cubit.state, TemperatureUnit.celsius);
    });
  });
}
