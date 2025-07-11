import 'package:flutter/material.dart';

class NavigatorConfig {
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getNavigatorKey() {
    return _navigatorKey;
  }
}
