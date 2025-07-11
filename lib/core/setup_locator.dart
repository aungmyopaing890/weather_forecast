import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  _injectServices();
  _injectCubits();
  _injectRepositories();
}

void _injectServices() {}

void _injectCubits() {}

void _injectRepositories() {}
